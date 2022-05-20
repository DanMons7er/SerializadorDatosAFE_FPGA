#!/usr/bin/env python3

from argparse import ArgumentError
from migen import *
from litedram.common import *
from migen.genlib.fsm import *

def ClkPerBit(f_In, baudRate):
    # This function helps translating system clock to communication clock (when to sample data)
    clkPerBitCounter = f_In // baudRate # Integer Division 
    if clkPerBitCounter <= 0:
        raise ArgumentError("Output frequency is higher than system frequency")
    
    # Value is returned to the system
    return clkPerBitCounter

class UART (Module):
    def __init__(self, serialPorts, InputFrequency, BaudRate):    
        # Reset
        self.reset= Signal()

        # Receiver 
        # Inputs
        self.rxData = Signal(8)        
        # Outputs
        self.rxDone = Signal()
        self.rxError = Signal()
        # Aux Signals
        self.bitRxQuantity = Signal(3)

        # Transmitter
        # Inputs
        self.txData = Signal(8)
        self.startTx = Signal()
        # Outputs
        self.txActive = Signal()
        self.txDone = Signal()
        # Aux Signals
        self.auxSysTxData = Signal(8)
        self.bitTxQuantity = Signal(3)

        ####################################################################################################
        # RECEIVER 

        # Clock Counter For System Operation
        clkCounter = ClkPerBit(f_In=InputFrequency, baudRate=BaudRate)
        AuxCountValue = clkCounter - 1 # Used To Ensure A Whole Bit Cycle Has Passed
        rxCounter = Signal(max=clkCounter) # We create counter for rx data sampling
        self.rxSample = Signal() # Signal That Tells FSM To Sample Data
        self.comb += self.rxSample.eq(rxCounter == AuxCountValue) # Sample Each Time Counter is AuxCountValue
        # Synchronous Process To Tell The FSM When Data Is Sampled
        self.sync += [ 
            If((rxCounter == AuxCountValue), 
                rxCounter.eq(0)
            ).Else(
                rxCounter.eq(rxCounter + 1)
            )
        ]

        # Receiver Finite State Machine
        rxFSM = FSM(reset_state="Idle")
        self.submodules += rxFSM

        # States Definition
        rxFSM.act("Idle",
            self.rxDone.eq(0),
            self.rxError.eq(0),
            If((~serialPorts.rx),
                # Detection of Start Bit
                NextValue(rxCounter, 0),
                NextState("StartBit")
            )
        )
        rxFSM.act("StartBit",
            If((rxCounter == ((AuxCountValue)// 2)),
                If((~serialPorts.rx),
                    # Counter is reset
                    NextValue(rxCounter, 0),
                    NextState("DataReception")
                ).Else(
                    NextState("Idle")
                )                
            )
        )
        rxFSM.act("DataReception",
            # Increase Bit Received Quantity
            If(self.rxSample,
                # Since We're At Half Bit, We Can Sample
                #self.rxData[self.bitRxQuantity].eq(serialPorts.rx),  
                NextValue(self.rxData, Cat(self.rxData[1:8], serialPorts.rx)),
                NextValue(self.bitRxQuantity, self.bitRxQuantity + 1),                                              
                If(self.bitRxQuantity == 7,
                    NextValue(self.bitRxQuantity, 0),
                    NextState("StopBit")
                )
            )
        )
        rxFSM.act("StopBit",
            # Wait for the stop bit to finish
            If(self.rxSample,
                If((~serialPorts.rx),
                    NextState("Error")
                ).Else(
                    self.rxDone.eq(1),
                    NextState("LineClean")
                )                
            )
        )
        rxFSM.act("LineClean",           
            If((~serialPorts.rx),
                NextState("Error")
            ).Elif((rxCounter == (AuxCountValue // 2)),
                self.rxDone.eq(1),
                NextState("Idle")
            )
        )
        rxFSM.act("Error",
            self.rxDone.eq(0),
            self.rxError.eq(1)
        )

        ####################################################################################################
        # TRANSMITTER

        # Clock Counter For System Operation
        txCounter = Signal(max=clkCounter) # We create counter for rx data sampling
        self.txSample = Signal() # Signal That Tells FSM To Sample Data
        self.comb += self.txSample.eq(txCounter == AuxCountValue) # Sample Each Time Counter is AuxCountValue
        # Syncrhonous Process To Tell The FSM When Data Is Sampled
        self.sync += [
            If((txCounter == AuxCountValue),
                txCounter.eq(0)      
            ).Else(
                txCounter.eq(txCounter + 1)
            )
        ]

        # Transmitter Finite State Machine
        txFSM = FSM(reset_state="Idle")
        self.submodules += txFSM

        # States Definition
        txFSM.act("Idle",
            self.txActive.eq(0),            
            self.txDone.eq(0),
            NextValue(serialPorts.tx, 1),
            If(self.startTx,
                NextValue(self.auxSysTxData, self.txData),
                NextValue(txCounter, 0),
                NextState("StartBit")
            )
        )
        txFSM.act("StartBit",
            self.txActive.eq(1),
            NextValue(serialPorts.tx, 0),
            If(self.txSample,
                NextState("DataSend")
            )
        )
        txFSM.act("DataSend",
            self.txActive.eq(1),
            NextValue(serialPorts.tx, self.auxSysTxData[0]),            
            If(self.txSample,
                NextValue(self.auxSysTxData, Cat(self.auxSysTxData[1:8], 0)),
                NextValue(self.bitTxQuantity, self.bitTxQuantity + 1),
                If(self.bitTxQuantity == 7,
                    NextValue(self.bitTxQuantity, 0),
                    NextState("StopBit")
                )
            )
        )
        txFSM.act("StopBit",
            self.txActive.eq(1),
            NextValue(serialPorts.tx, 1),
            If(self.txSample,
                self.txDone.eq(1),
                NextState("LineClean")
            )
        )
        txFSM.act("LineClean",
            self.txActive.eq(0),
            self.txDone.eq(1),
            NextState("Idle")
        )