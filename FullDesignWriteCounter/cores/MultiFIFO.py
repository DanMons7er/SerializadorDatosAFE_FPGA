#!/usr/bin/env python3

from curses.ascii import SI
from fcntl import I_CANPUT
from migen import *
from litedram.common import *
from litedram.phy.dfi import *
# from fifo import *

class FIFO (Module):
    def __init__(self, AlmostFullOffset=128, AlmostEmptyOffset=128, Width=0, pointersLength=9, fifoSize="18Kb", FWFT="FALSE"):
        
        # Input Signals
        self.di = Signal(Width)
        self.rdClk = Signal()
        self.rdEnable = Signal()
        self.wrClk = Signal()
        self.wrEnable = Signal() 
        self.reset = Signal()

        # Output Signals
        self.almostEmpty = Signal()
        self.almostFull = Signal()
        self.do = Signal(Width)
        self.empty = Signal()
        self.full = Signal()
        self.readError = Signal()
        self.writeError = Signal()
        self.rdCount = Signal(pointersLength)
        self.wrCount = Signal(pointersLength)

        # Data Output
        self.do = Signal(Width)

        self.fifo = Instance("FIFO_DUALCLOCK_MACRO",
            p_DEVICE = "7SERIES",
            p_ALMOST_FULL_OFFSET = AlmostFullOffset,
            p_ALMOST_EMPTY_OFFSET = AlmostEmptyOffset,
            p_DATA_WIDTH = Width,
            p_FIFO_SIZE = fifoSize,
            p_FIRST_WORD_FALL_THROUGH = FWFT,

            o_ALMOSTEMPTY = self.almostEmpty,
            o_ALMOSTFULL = self.almostFull,
            o_DO = self.do,
            o_EMPTY = self.empty,
            o_FULL = self.full,
            o_RDERR = self.readError,
            o_WRERR = self.writeError,
            o_RDCOUNT = self.rdCount,
            o_WRCOUNT = self.wrCount,
            i_DI = self.di,
            i_RDCLK = self.rdClk,
            i_RDEN = self.rdEnable,
            i_RST = self.reset,
            i_WRCLK = self.wrClk,
            i_WREN = self.wrEnable
        )
    
        self.specials += self.fifo

class MultiFIFO (Module):
    def __init__(self, RdClk="sys", WrClk="sys", RdClkFrec=0, WrClkFrec=0, Quantity=0, AlFulOff=128, AlEmOff=128, fifoWidth=0, fifoPointersLength=9, Size="18Kb", needFWFT="FALSE"):

        # Input Signals
        self.clkRST = Signal()
        self.memoryRST = Signal()
        self.inputData = Signal(fifoWidth)
        self.readClock = ClockSignal(cd=RdClk)
        self.writeClock = ClockSignal(cd=WrClk)
        self.readEnable = Signal()
        self.writeEnable = Signal()
        self.internalClock = Signal()
        if WrClkFrec > RdClkFrec:
            self.comb += [
                self.internalClock.eq(self.writeClock)
            ]
        else: # WrClkFrec <= RdClkFrec:
            self.comb += [
                self.internalClock.eq(self.readClock)
            ]   

        # Memory Write And Read Clock Domains
        # self.clock_domains.cd_wr = ClockDomain()
        # self.clock_domains.cd_rd = ClockDomain()
        # self.comb += [
        #     self.cd_wr.clk.eq(ClockSignal(cd=WrClk)),
        #     self.cd_wr.rst.eq(self.clkRST),
        #     self.cd_rd.clk.eq(ClockSignal(cd=RdClk)),
        #     self.cd_rd.rst.eq(self.clkRST),
        # ]

        # Output Signals
        self.sysAlmostEmpty = Signal()
        self.sysAlmostFull = Signal()
        self.outputData = Signal(fifoWidth)
        self.multiFIFOEmpty = Signal()
        self.multiFIFOFull = Signal()
        self.sysReadError = Signal()
        self.sysWriteError = Signal()
        self.sysReadCount = Signal(fifoPointersLength)
        self.sysWriteCount = Signal(fifoPointersLength)  

        # Reset Management
        self.initialReset = Signal()
        self.resetCounter = Signal(3)
        self.automaticReset = Signal()
        self.memoryReset = Signal()
        # Reset Control For Flag Management (See Xilinx Guide)
        if WrClkFrec > RdClkFrec:
            self.sync.bufrFrameClk += [
                If((~self.initialReset), 
                    self.resetCounter.eq(self.resetCounter + 1),
                    self.automaticReset.eq(1),
                    If(self.resetCounter == 5,
                        self.initialReset.eq(1), # Reset has been finished
                        self.resetCounter.eq(0),
                        self.automaticReset.eq(0)
                    )
                )                
            ]
        elif WrClkFrec == RdClkFrec:
            self.sync.bufrFrameClk += [
                If((~self.initialReset), 
                    self.resetCounter.eq(self.resetCounter + 1),
                    self.automaticReset.eq(1),
                    If(self.resetCounter == 5,
                        self.initialReset.eq(1), # Reset has been finished
                        self.resetCounter.eq(0),
                        self.automaticReset.eq(0)
                    )
                )                
            ]
        else:
            self.sync.sys += [
                If((~self.initialReset), 
                    self.resetCounter.eq(self.resetCounter + 1),
                    self.automaticReset.eq(1),
                    If(self.resetCounter == 5,
                        self.initialReset.eq(1), # Reset has been finished
                        self.resetCounter.eq(0),
                        self.automaticReset.eq(0)
                    )
                )
            ]
        # Memory Reset Signal
        self.comb += [
            self.memoryReset.eq(self.memoryRST | self.automaticReset)
        ]

        if Quantity == 1:
            OneFIFO = FIFO(AlmostFullOffset=AlFulOff, AlmostEmptyOffset=AlEmOff, Width=fifoWidth, pointersLength=fifoPointersLength, fifoSize=Size, FWFT=needFWFT)
            self.submodules += OneFIFO

            # Inputs
            self.comb += [
                OneFIFO.di.eq(self.inputData),
                OneFIFO.rdClk.eq(self.readClock),
                OneFIFO.rdEnable.eq(self.readEnable),
                OneFIFO.wrClk.eq(self.writeClock),
                OneFIFO.wrEnable.eq(self.writeEnable), 
                OneFIFO.reset.eq(self.memoryReset)
            ]

            # Outputs
            self.comb += [
                self.sysAlmostEmpty.eq(OneFIFO.almostEmpty),
                self.sysAlmostFull.eq(OneFIFO.almostFull),
                self.outputData.eq(OneFIFO.do),
                self.multiFIFOEmpty.eq(OneFIFO.empty),
                self.multiFIFOFull.eq(OneFIFO.full),
                self.sysReadError.eq(OneFIFO.readError),
                self.sysWriteError.eq(OneFIFO.writeError),
                self.sysReadCount.eq(OneFIFO.rdCount),
                self.sysWriteCount.eq(OneFIFO.wrCount)
            ]
        elif Quantity == 2:
            FirstFIFO = FIFO(AlmostFullOffset=AlFulOff, Width=fifoWidth, pointersLength=fifoPointersLength, fifoSize=Size, FWFT="TRUE")
            SecondFIFO = FIFO(AlmostEmptyOffset=AlEmOff, Width=fifoWidth, pointersLength=fifoPointersLength, fifoSize=Size)
            # NOR Aux Signal
            self.norOutput2 = Signal()            
            self.submodules += [
                FirstFIFO,
                SecondFIFO
            ]

            # Inputs
            self.comb += [
                # NOR Gate Signal
                self.norOutput2.eq(~(SecondFIFO.full | FirstFIFO.empty)),

                # First FIFO
                FirstFIFO.reset.eq(self.memoryReset),
                FirstFIFO.di.eq(self.inputData),
                FirstFIFO.rdClk.eq(self.internalClock),
                FirstFIFO.rdEnable.eq(self.norOutput2),
                FirstFIFO.wrClk.eq(self.writeClock),
                FirstFIFO.wrEnable.eq(self.writeEnable),

                # Second FIFO
                SecondFIFO.reset.eq(self.memoryReset),
                SecondFIFO.di.eq(FirstFIFO.do),
                SecondFIFO.rdClk.eq(self.readClock),
                SecondFIFO.rdEnable.eq(self.readEnable),
                SecondFIFO.wrClk.eq(self.internalClock),
                SecondFIFO.wrEnable.eq(self.norOutput2)
            ]

            # Outputs
            self.comb += [
                self.sysAlmostEmpty.eq(SecondFIFO.almostEmpty),
                self.sysAlmostFull.eq(FirstFIFO.almostFull),
                self.outputData.eq(SecondFIFO.do),
                self.multiFIFOEmpty.eq(SecondFIFO.empty),
                self.multiFIFOFull.eq(FirstFIFO.full),
                self.sysReadError.eq(SecondFIFO.readError),
                self.sysWriteError.eq(FirstFIFO.writeError),
                self.sysReadCount.eq(SecondFIFO.rdCount),
                self.sysWriteCount.eq(FirstFIFO.wrCount)
            ]
        else:
            # Internal FIFO Creation
            intFIFO = [Module]*(Quantity)

            intFIFO[0] = FIFO(AlmostFullOffset=AlFulOff, Width=fifoWidth, pointersLength=fifoPointersLength, fifoSize=Size, FWFT="TRUE")
            intFIFO[Quantity - 1] = FIFO(AlmostEmptyOffset=AlEmOff, Width=fifoWidth, pointersLength=fifoPointersLength, fifoSize=Size)
            # Standard FIFO Creation
            self.submodules += [
                intFIFO[0],
                intFIFO[Quantity - 1]
            ]

            # Other FIFOs instantiation
            for i in range(Quantity - 2):
                intFIFO[i + 1] = FIFO(
                    Width=fifoWidth, 
                    pointersLength=fifoPointersLength, 
                    fifoSize=Size, 
                    FWFT="TRUE")
                self.submodules += intFIFO[i + 1]

            # NOR Aux Signal
            self.norOutput = Signal(Quantity - 1) 
            if Quantity == 3:
                self.comb += [
                    # NOR Aux Signal
                    self.norOutput[0].eq(~(intFIFO[1].full | intFIFO[0].empty)),
                    self.norOutput[1].eq(~(intFIFO[2].full | intFIFO[1].empty)),
                ]
            else:
                self.comb += [
                    # NOR Aux Signal
                    self.norOutput[0].eq(~(intFIFO[1].full | intFIFO[0].empty)),
                    self.norOutput[Quantity - 2].eq(~(intFIFO[Quantity - 1].full | intFIFO[Quantity - 2].empty)),
                ]
                for i in range(Quantity - 3):
                    self.comb += [
                        self.norOutput[i + 1].eq(~(intFIFO[i + 2].full | intFIFO[i + 1].empty)),
                    ]
        
            # Inputs
            self.comb += [
                # Standard FIFOs                
                # First FIFO
                intFIFO[0].reset.eq(self.memoryReset),
                intFIFO[0].di.eq(self.inputData),
                intFIFO[0].rdClk.eq(self.internalClock),
                intFIFO[0].rdEnable.eq(self.norOutput[0]), 
                intFIFO[0].wrClk.eq(self.writeClock),
                intFIFO[0].wrEnable.eq(self.writeEnable),
                # Second FIFO
                intFIFO[Quantity - 1].reset.eq(self.memoryReset), 
                intFIFO[Quantity - 1].di.eq(intFIFO[Quantity - 2].do),
                intFIFO[Quantity - 1].rdClk.eq(self.readClock), 
                intFIFO[Quantity - 1].rdEnable.eq(self.readEnable), 
                intFIFO[Quantity - 1].wrClk.eq(self.internalClock), 
                intFIFO[Quantity - 1].wrEnable.eq(self.norOutput[Quantity - 2])
            ]
            # Internal FIFOs
            for i in range(Quantity - 2):
                self.comb += [
                    intFIFO[i+1].reset.eq(self.memoryReset),
                    intFIFO[i+1].di.eq(intFIFO[i].do),
                    intFIFO[i+1].rdClk.eq(self.internalClock),
                    intFIFO[i+1].rdEnable.eq(self.norOutput[i + 1]), 
                    intFIFO[i+1].wrClk.eq(self.internalClock),
                    intFIFO[i+1].wrEnable.eq(self.norOutput[i]),
                ]

            # Outputs
            self.comb += [
                self.sysAlmostEmpty.eq(intFIFO[Quantity - 1].almostEmpty),
                self.sysAlmostFull.eq(intFIFO[0].almostFull),
                self.outputData.eq(intFIFO[Quantity - 1].do),
                self.multiFIFOEmpty.eq(intFIFO[Quantity - 1].empty),
                self.multiFIFOFull.eq(intFIFO[0].full),
                self.sysReadError.eq(intFIFO[Quantity - 1].readError),
                self.sysWriteError.eq(intFIFO[0].writeError),
                self.sysReadCount.eq(intFIFO[Quantity - 1].rdCount),
                self.sysWriteCount.eq(intFIFO[0].wrCount)
            ]