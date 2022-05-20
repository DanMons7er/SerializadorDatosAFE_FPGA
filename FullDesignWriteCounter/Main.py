#!/usr/bin/env python3

import argparse
import imp
from migen import *
from common.platforms import nexys_video
from cores.Buffers import *
from cores.PLL import PllInstance
from cores.Mux import MuxInstance
from cores.ISerDeseExpansion import *
from cores.FSMBit import *
from cores.FSMFrame import *
from cores.FSMFrameAlt import *
from cores.uart import UART
from cores.MultiFIFO import *
from cores.fsmWriteToFIFO import *
from cores.fsmReadFromFIFO import *

class Entity (Module):
    def __init__(self, platform):
        # ENTITY INPUTS
        ##############################################################################################
        # AFE INPUTS
        self.afe = platform.request("afe")
        # AFE Clocks
        self.bitClkP = self.afe.dclkp
        self.bitClkN = self.afe.dclkn
        self.frameClkP = self.afe.fclkp
        self.frameClkN = self.afe.fclkn
        # AFE Data
        self.dataP = self.afe.datap
        self.dataN = self.afe.datan
        ##############################################################################################
        # USER INPUTS
        # BUTTONS
        self.reset = platform.request("user_btn", 0)
        self.memoryReset = platform.request("user_btn", 1) # Reset Signal For The Memories
        # SWITCHES
        # Allignment Process
        self.modeSelector = platform.request("user_sw", 7)
        self.startAlignmentProcess = platform.request("user_sw", 6)
        self.fsmFrameManualEnable = platform.request("user_sw", 5)
        # Data Sampling Control Switches 
        self.samplingMode = platform.request("user_sw", 4)
        # Memories
        self.wrEnable = platform.request("user_sw", 3) 
        # USER LED INDICATORS
        self.led = []
        for i in range(8):
            self.led.append(platform.request("user_led", i))
        ##############################################################################################
        # CLOCK INPUTS
        self.sysClk = platform.request("clk100")
        ##############################################################################################
        # COMMUNICATION INPUTS
        serial = platform.request("serial") # Serial Object Is Retrieved From Constraints
        ##############################################################################################
        # DESIGN PARAMETERS
        # NUMBER OF CHANNELS DEFINITION
        Channels = 8
        # WRITE & READ CLOCK PERIOD (ns)
        WrClk = 25
        RdClk = 10
        # SAMPLING TIME DEFINITION (ms)
        Sampling = 2000
        CounterAux = (Sampling * 1000) // WrClk
        Counter = CounterAux - 1

        ##############################################################################################
        # AUXILIARY GLOBAL SIGNALS
        # Data Allignment Signals
        self.globalMuxCtrl = Signal(2)
        self.globalBitslip = Signal()
        self.allignmentFinished = Signal()
        # Memory Data Aux Signals
        self.firstByte = Signal(8)
        self.secondByte = Signal(8)
        # Read Enable Signals
        self.frequencyRdEnable = Signal()
        self.readEnableWithFreq = Signal(Channels)
        self.memoryByte = Signal(8) 
        self.writeCounter = Signal(11)
        self.readyToSendData = Signal()
        self.startReadingMemories = Signal()
        self.cycleFinished = Signal()
        self.resetReadingFlags = Signal(4)
        self.memoriesWereFull = Signal()
        # Write Enable Signals
        self.wrBigCounter = Signal(max=CounterAux)
        self.frequencyWrEnable = Signal()
        self.writeEnableWithFreq = Signal()
        self.countersAreDifferent = Signal()
        self.memoryWasFull = Signal()
        # Transmission Aux Signals
        self.lastMemoryAdressed = Signal(3)
        self.allowCounterTx = Signal()
        self.txEnableCounter = Signal(2)
        self.byteCounter = Signal()
        self.operationCount = Signal(2)
        self.alreadySeenUART= Signal()
        self.changeMemory = Signal()
        self.firstOperationStarted = Signal()
        self.secondOperationStarted = Signal()
        self.secondOperationStartedAux = Signal()
        self.dataToSend = Signal(14)
        self.memoryAdressed = Signal(3)
        self.rdEnableFromLogic = Signal()
        # Memory Flags
        self.memoriesEmpty = Signal()
        self.memoriesFull = Signal()
        self.memoriesReadError = Signal()
        self.memoriesWriteError = Signal()

        ##############################################################################################
        # CLOCK MANAGEMENT MODULE (AFE - NON AFE RELATED CLOCKS)
        # Clock Domains
        self.clock_domains.cd_sys = ClockDomain()
        self.clock_domains.cd_sys180 = ClockDomain()
        self.clock_domains.cd_digClk = ClockDomain()
        self.clock_domains.cd_muxClk = ClockDomain()
        self.clock_domains.cd_invMuxClk = ClockDomain()
        self.clock_domains.cd_bufrFrameClk = ClockDomain()
        self.clock_domains.cd_invBufrFrameClk = ClockDomain()

        # ENTITY MODULES
        ##############################################################################################
        # ADQUISITION MODULE
        ##############################################################################################
        # CLOCKING INSTANCES
        # AFE BUFFERS
        self.digitalBuffer = DifferentialBuffer()
        self.frameBuffer = DifferentialBuffer()
        self.buffR = BuffR()
        # GENERAL BUFFER FOR SYS180 CLOCK
        self.invSysClk = BUFG()
        # Buffers Input Declaration
        self.comb += [
            self.digitalBuffer.inP.eq(self.bitClkP),
            self.digitalBuffer.inN.eq(self.bitClkN),
            self.frameBuffer.inP.eq(self.frameClkP),
            self.frameBuffer.inN.eq(self.frameClkN),
            self.buffR.input.eq(self.frameBuffer.O),
            self.invSysClk.input.eq(self.sysClk) #self.invSysClk.input.eq(self.pllSystem.phase[4])
        ]

        # Clock Inputs Declaration
        self.comb += [
            # System Clock
            self.cd_sys.clk.eq(self.sysClk),
            self.cd_sys.rst.eq(self.reset),
            # Inverted System Clock
            self.cd_sys180.clk.eq(~self.invSysClk.O),
            self.cd_sys180.rst.eq(self.reset),
            # Digital Clock
            self.cd_digClk.clk.eq(self.digitalBuffer.O),
            self.cd_digClk.rst.eq(self.reset),
            # Frame Clock
            self.cd_bufrFrameClk.clk.eq(self.buffR.O),
            self.cd_bufrFrameClk.rst.eq(self.reset),
            self.cd_invBufrFrameClk.clk.eq(~self.buffR.O),
            self.cd_invBufrFrameClk.rst.eq(self.reset)
        ]

        # PLL (DIGITAL CLOCK FROM AFE)
        self.pll = PllInstance(5, 1, 3.571)
        # PLL Input Declaration
        self.comb += [
            self.pll.Clk.eq(ClockSignal(cd="digClk")),
            self.pll.Reset.eq(self.reset)
        ]

        # MUX FOR PHASE SELECTOR
        self.mux = MuxInstance()
        # MUX Input Declaration
        self.comb += [
            self.mux.phase.eq(self.pll.phase),
            # Clock Domains Declaration
            self.cd_muxClk.clk.eq(self.mux.OC),
            self.cd_muxClk.rst.eq(self.reset),
            self.cd_invMuxClk.clk.eq(~self.mux.OC),
            self.cd_invMuxClk.rst.eq(self.reset)
        ]

        ##############################################################################################
        # DATA ADQUISITION MODULE
        # Buffers
        self.dataBuffer = [Module]*Channels
        for i in range(Channels):
            self.dataBuffer[i] = DifferentialBuffer()
            self.submodules += [
                # Module Generation
                self.dataBuffer[i]
            ]
            # Buffers Input Declaration
            self.comb += [
                self.dataBuffer[i].inP.eq(self.dataP[i]),
                self.dataBuffer[i].inN.eq(self.dataN[i])
            ]

        # DATA READING INSTANCES
        self.iserdeseData = [Module]*Channels
        for i in range(Channels):
            self.iserdeseData[i] = ISerDese(InClk="muxClk", InvClk="invMuxClk", DivClk="bufrFrameClk")
            self.submodules += [
                # Module Generation
                self.iserdeseData[i]
            ]
            # ISerDese Input Declaration
            self.comb += [
                self.iserdeseData[i].mainDataInput.eq(self.dataBuffer[i].O),
                self.iserdeseData[i].mainReset.eq(self.reset)
            ]

        # ISERDESE FOR AUTOMATIC FRAME ALLIGNMENT
        self.iserdeseFrame = ISerDese(InClk="muxClk", InvClk="invMuxClk", DivClk="bufrFrameClk")
        # ISerDese Input Declaration
        self.comb += [
            self.iserdeseFrame.mainDataInput.eq(self.frameBuffer.O),
            self.iserdeseFrame.mainReset.eq(self.reset)
        ]

        ##############################################################################################
        # DATA ALLIGNMENT MODULE
        ##############################################################################################
        # USER ALLIGNMENT
        # FSM Bit Allignment
        self.fsmForBit = FSMBit(clkSig="invMuxClk")
        # FSM In/Out Declarations
        self.comb += [
            # Inputs
            self.fsmForBit.reset.eq(self.reset),
            self.fsmForBit.locked.eq(self.pll.Locked),
            self.fsmForBit.qVector.eq(self.iserdeseData[0].mainQVector),
            self.fsmForBit.modeSelected.eq(self.modeSelector),
            self.fsmForBit.startProcess.eq(self.startAlignmentProcess)
        ]
        # FSM Frame Allignment
        self.fsmForFrame = FSMFrame(clkSig="invBufrFrameClk")
        # FSM In/Out Declarations
        self.comb += [
            # Inputs
            self.fsmForFrame.reset.eq(self.reset),
            self.fsmForFrame.qVector.eq(self.iserdeseData[0].mainQVector),
            self.fsmForFrame.fsmBitFinished.eq(self.fsmForBit.finished),
            self.fsmForFrame.fsmEnable.eq(self.fsmFrameManualEnable),
        ]
        ##############################################################################################
        # SYSTEM ALLIGNMENT
        # FSM Frame Default Allignment
        self.fsmForFrameDefault = FSMFrameDefault(clkSig="invBufrFrameClk")
        # FSM In/Out Declarations
        self.comb += [
            # Inputs
            self.fsmForFrameDefault.reset.eq(self.reset),
            self.fsmForFrameDefault.qVector.eq(self.iserdeseFrame.mainQVector),
            self.fsmForFrameDefault.pllLocked.eq(self.pll.Locked),
            self.fsmForFrameDefault.modeSelected.eq(self.modeSelector),
            self.fsmForFrameDefault.startProcess.eq(self.startAlignmentProcess)
        ]
        ##############################################################################################
        # ALLIGNMENT DONE SIGNALS
        self.comb += [
            self.allignmentFinished.eq(self.fsmForFrame.allignmentDone | self.fsmForFrameDefault.allignmentDone)
        ]
        ##############################################################################################
        # CHOOSING BETWEEN BOTH MODES
        # Control Signals Definition
        self.comb += [
            self.globalMuxCtrl.eq(self.fsmForBit.phaseCounter),
            self.globalBitslip.eq(self.fsmForFrame.bitslip | self.fsmForFrameDefault.bitslip)
        ]
        # ISerDese And Mux Control Signals Definition
        self.comb += [
            # Mux Controller
            self.mux.muxCtrl.eq(self.globalMuxCtrl),
            # Bitslip
            self.iserdeseFrame.mainBitslipInput.eq(self.globalBitslip)
        ]
        # Data ISerDese Bitslip
        for i in range(Channels):
            self.comb += [
                # Bitslip
                self.iserdeseData[i].mainBitslipInput.eq(self.globalBitslip),
            ]

        ##############################################################################################
        # MEMORY MODULE
        # NUMBER OF MEMORIES INSTANTIATION
        self.memory = [Module]*Channels # Memory List
        self.fsmwCtrl = [Module]*Channels # Writing Control For Memories List
        self.fsmrCtrl = [Module]*Channels # Reading Control For Memories List

        # Quantity Of Memories Is Created
        for i in range(Channels):
            # FIFO CONTROLLERS INSTANTIATION
            # FSM Write Control
            self.fsmwCtrl[i] = FSMWriteFIFO()
            # FSM Read Control
            self.fsmrCtrl[i] = FSMReadFIFO()
            # MEMORY INSTANTIATION
            self.memory[i] = MultiFIFO(
                RdClk="sys", 
                WrClk="bufrFrameClk", 
                RdClkFrec=100, 
                WrClkFrec=40, 
                Quantity=1, 
                AlFulOff=8, 
                AlEmOff=6, 
                fifoWidth=14, 
                fifoPointersLength=11, 
                Size="36Kb"
            )
            # Specialized Logic Module Generation
            self.submodules += [
                self.fsmwCtrl[i],
                self.fsmrCtrl[i],
                self.memory[i]
            ]

            # INPUTS DEFINITION
            # Memory 
            self.comb += [
                self.memory[i].clkRST.eq(self.reset),
                self.memory[i].memoryRST.eq(self.memoryReset),
                self.memory[i].inputData.eq(self.iserdeseData[i].mainQVector),
                self.memory[i].readEnable.eq(self.fsmrCtrl[i].enableReadingFIFO),
                self.memory[i].writeEnable.eq(self.fsmwCtrl[i].enableWritingFIFO)
            ]
            # FSM Write
            self.comb += [
                self.fsmwCtrl[i].fifoAlmostFullFlag.eq(self.memory[i].sysAlmostFull),
                self.fsmwCtrl[i].extWriteEnable.eq(self.writeEnableWithFreq),
                self.fsmwCtrl[i].fifowrError.eq(self.memory[i].sysWriteError),
                self.fsmwCtrl[i].dataReady.eq(self.allignmentFinished)
            ]
            # FSM Read 
            self.comb += [
                self.fsmrCtrl[i].extReadEnable.eq(self.readEnableWithFreq[i]),
                self.fsmrCtrl[i].fifordError.eq(self.memory[i].sysReadError),
                self.fsmrCtrl[i].fifoEmptyFlag.eq(self.memory[i].multiFIFOEmpty)
            ]

        # MEMORY MODULE FLAG SIGNALS
        self.comb += [
            # Empty Memories
            self.memoriesEmpty.eq(self.memory[0].multiFIFOEmpty & self.memory[1].multiFIFOEmpty & self.memory[2].multiFIFOEmpty & self.memory[3].multiFIFOEmpty
            & self.memory[4].multiFIFOEmpty & self.memory[5].multiFIFOEmpty & self.memory[6].multiFIFOEmpty & self.memory[7].multiFIFOEmpty),
            # Full Memories
            self.memoriesFull.eq(self.memory[0].sysAlmostFull & self.memory[1].sysAlmostFull & self.memory[2].sysAlmostFull & self.memory[3].sysAlmostFull
            & self.memory[4].sysAlmostFull & self.memory[5].sysAlmostFull & self.memory[6].sysAlmostFull & self.memory[7].sysAlmostFull),
            # Memories Reading Error (Any Memory)
            self.memoriesReadError.eq(self.memory[0].sysReadError | self.memory[1].sysReadError | self.memory[2].sysReadError | self.memory[3].sysReadError
            | self.memory[4].sysReadError | self.memory[5].sysReadError | self.memory[6].sysReadError | self.memory[7].sysReadError),
            # Memories Writing Error (Any Memory)
            self.memoriesWriteError.eq(self.memory[0].sysWriteError | self.memory[1].sysWriteError | self.memory[2].sysWriteError | self.memory[3].sysWriteError
            | self.memory[4].sysWriteError | self.memory[5].sysWriteError | self.memory[6].sysWriteError | self.memory[7].sysWriteError),
        ]  

        ##############################################################################################
        # SERIAL MODULE
        # SERIAL PORT CREATION
        self.uart = UART(serial, InputFrequency=100000000, BaudRate=921600) 

        # PROCESS THAT DEFINES HOW THE MEMORIES ARE READ
        # Read Enable Creation (According To Sampling Mode)
        self.sync.sys180 += [
            If(~(self.samplingMode),
                # Reading The Memory Inmediately (Real Time Purpose)
                If(self.allignmentFinished & (self.writeCounter != self.memory[0].sysWriteCount),
                    self.writeCounter.eq(self.memory[0].sysWriteCount),
                    self.readyToSendData.eq(1),
                ),
                If(self.changeMemory, 
                    If(self.memoryAdressed == 7,
                        self.memoryAdressed.eq(0)
                    ).Else(
                        self.memoryAdressed.eq(self.memoryAdressed + 1)
                    )
                ),
                If((((self.lastMemoryAdressed != self.memoryAdressed) & (self.memoryAdressed != 0)) | (self.readyToSendData & (~self.memory[0].multiFIFOEmpty))),
                    self.lastMemoryAdressed.eq(self.memoryAdressed),
                    self.frequencyRdEnable.eq(1),
                    self.readyToSendData.eq(0)
                ).Else(
                    self.frequencyRdEnable.eq(0)
                )   
            ).Else(
                # Reading Memories After They Have Been Filled
                If(self.memoriesFull, 
                    self.memoriesWereFull.eq(1)
                ),                
                If(self.memoriesWereFull,
                    If((~self.memoriesFull) & self.memoryWasFull,
                        self.resetReadingFlags.eq(self.resetReadingFlags + 1),
                        If(self.resetReadingFlags == 9,
                            self.resetReadingFlags.eq(0),
                            self.memoryWasFull.eq(0)
                        )
                    ),
                    If(self.memory[0].sysAlmostFull & (~self.memoryWasFull),
                        self.startReadingMemories.eq(1),
                        self.memoryWasFull.eq(1)                    
                    ),
                    If(self.changeMemory, 
                        If(self.memoryAdressed == 7,
                            self.memoryAdressed.eq(0),
                            If(self.memory[0].multiFIFOEmpty,
                                self.memoriesWereFull.eq(0)
                            ),
                        ).Else(
                            self.memoryAdressed.eq(self.memoryAdressed + 1),
                        )
                    ),
                    If(((self.lastMemoryAdressed != self.memoryAdressed) | self.startReadingMemories), # & (~(self.memory[0].multiFIFOEmpty & self.cycleFinished))) | self.startReadingMemories),
                        self.lastMemoryAdressed.eq(self.memoryAdressed),
                        self.startReadingMemories.eq(0),
                        self.frequencyRdEnable.eq(1)
                    ).Else(
                        self.frequencyRdEnable.eq(0)
                    )
                )
            )                         
        ]
        # Read Enable Adjustment
        for i in range(Channels):
            self.comb += [
                self.readEnableWithFreq[i].eq(self.frequencyRdEnable & self.memoryByte[i])
            ]

        # PROCESS THAT DEFINES HOW THE MEMORIES ARE WRITTEN
        # Write Enable Creation (Sampling Time Generated)
        self.sync.invBufrFrameClk += [
            # Only If The Data Is Alligned
            If(self.allignmentFinished,
                self.wrBigCounter.eq(self.wrBigCounter + 1),
                If(self.wrBigCounter == Counter,
                    self.wrBigCounter.eq(0),
                    self.frequencyWrEnable.eq(1)
                ).Else(
                    self.frequencyWrEnable.eq(0)
                )
            )
        ]
        # Write Enable Adjustment
        self.comb += [
            self.writeEnableWithFreq.eq(self.wrEnable & self.frequencyWrEnable & (~self.memoriesWereFull))
        ]  

        # PROCESS THAT DEFINES THE DATA THAT IS GOING TO BE SENT
        # Depends On The Memory That Is Being Read
        self.comb += [
            # Acts As A Multiplexer
            Case(self.memoryAdressed, {
                # Specific Data
                0: self.dataToSend.eq(self.memory[0].outputData),                
                1: self.dataToSend.eq(self.memory[1].outputData),
                2: self.dataToSend.eq(self.memory[2].outputData),
                3: self.dataToSend.eq(self.memory[3].outputData),
                4: self.dataToSend.eq(self.memory[4].outputData),
                5: self.dataToSend.eq(self.memory[5].outputData),
                6: self.dataToSend.eq(self.memory[6].outputData),
                7: self.dataToSend.eq(self.memory[7].outputData),
                "default": self.dataToSend.eq(self.memory[0].outputData)
            }),
            # CREATING READING DATA FREQUENCY ENABLER
            # "Bit Shifter"
            Case(self.memoryAdressed, {
                # Memory That Is Being Read
                0: self.memoryByte.eq(0b00000001),               
                1: self.memoryByte.eq(0b00000010),
                2: self.memoryByte.eq(0b00000100),
                3: self.memoryByte.eq(0b00001000),
                4: self.memoryByte.eq(0b00010000),
                5: self.memoryByte.eq(0b00100000),
                6: self.memoryByte.eq(0b01000000),
                7: self.memoryByte.eq(0b10000000),
                "default": self.memoryByte.eq(0b00000001)
            }),
            # Read Enable Is Assigned
            Case(self.memoryAdressed, {
                0: self.rdEnableFromLogic.eq(self.readEnableWithFreq[0]),
                1: self.rdEnableFromLogic.eq(self.readEnableWithFreq[1]),
                2: self.rdEnableFromLogic.eq(self.readEnableWithFreq[2]),
                3: self.rdEnableFromLogic.eq(self.readEnableWithFreq[3]),
                4: self.rdEnableFromLogic.eq(self.readEnableWithFreq[4]),
                5: self.rdEnableFromLogic.eq(self.readEnableWithFreq[5]),
                6: self.rdEnableFromLogic.eq(self.readEnableWithFreq[6]),
                7: self.rdEnableFromLogic.eq(self.readEnableWithFreq[7]),
                "default": self.rdEnableFromLogic.eq(self.readEnableWithFreq[0])
            }),
            # Transmitting Data Logic
            # Data Assignation
            Case(self.byteCounter, {
                0: self.uart.txData.eq(self.firstByte),
                1: self.uart.txData.eq(self.secondByte),
                "default": self.uart.txData.eq(self.firstByte)
            })
        ]

        # DATA BYTES ASSIGNATION ACCORDING TO LAST COMBINATORIAL PROCESS
        # First Byte
        for i in range(8):
            self.comb += self.firstByte[i].eq(self.dataToSend[i])
        # Second Byte
        for i in range(6):
            self.comb += self.secondByte[i].eq(self.dataToSend[i+8])  

        # DATA TRANSMISSION PROCESS
        self.sync += [
            # Initialize Flag For Data Transmission
            If(self.rdEnableFromLogic,
                self.allowCounterTx.eq(1)
            ),      
            # Give Some Time To Start Process      
            If(self.allowCounterTx,
                self.txEnableCounter.eq(self.txEnableCounter + 1),
                If(self.txEnableCounter == 2,
                    self.txEnableCounter.eq(0),
                    self.firstOperationStarted.eq(1),
                    self.allowCounterTx.eq(0),
                    self.byteCounter.eq(0),
                    self.uart.startTx.eq(1)
                )
            ),
            # Send First Byte
            If(self.uart.txDone & self.firstOperationStarted, 
                self.firstOperationStarted.eq(0),
                self.byteCounter.eq(1),
                self.uart.startTx.eq(1),
                self.secondOperationStartedAux.eq(1)
            ),
            # Send Second Byte
            If(self.secondOperationStartedAux,
                self.txEnableCounter.eq(self.txEnableCounter + 1),
                If(self.txEnableCounter == 3,
                    self.txEnableCounter.eq(0),
                    self.secondOperationStartedAux.eq(0),
                    self.secondOperationStarted.eq(1),
                    self.uart.startTx.eq(0),
                )
            ),
            # Stop Process / Change Memory Adressed
            If(self.uart.txDone & self.secondOperationStarted,
                self.secondOperationStarted.eq(0),
                self.changeMemory.eq(1)
            ).Else(
                self.changeMemory.eq(0)
            )
        ]

        # MODULES INSTANTIATION
        ##############################################################################################
        self.submodules += [
            # ADQUISITION
            self.digitalBuffer,
            self.frameBuffer,
            self.buffR,
            self.invSysClk,
            self.pll,
            self.mux,
            # ALLIGNMENT
            self.iserdeseFrame,
            self.fsmForBit,
            self.fsmForFrame,
            self.fsmForFrameDefault,
            # SERIAL
            self.uart
        ]

        # ENTITY OUTPUTS
        ##############################################################################################
        self.comb += [
            self.led[0].eq(self.memoryAdressed[2]),
            self.led[1].eq(self.memoryAdressed[1]),
            self.led[2].eq(self.memoryAdressed[0]),
            self.led[3].eq(self.memoriesEmpty),
            self.led[4].eq(self.memoriesReadError),
            self.led[5].eq(self.memoriesFull),
            self.led[6].eq(self.memoriesWriteError),
            self.led[7].eq(self.allignmentFinished)  
        ]

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--build", action="store_true")
    args = parser.parse_args()

    platform = nexys_video.Platform()
    entity = Entity(platform)

    if args.build:
        platform.build(entity)

if __name__ == "__main__":
    main()