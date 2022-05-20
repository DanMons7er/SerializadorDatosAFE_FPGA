#!/usr/bin/env python3

from migen import *
from migen.fhdl import verilog # Tal vez comentar
from litedram.common import *
from migen.genlib.fsm import FSM 

class FSMFrameDefault (Module):
    def __init__(self, clkSig="sys"):
        # Clock Domain Specification
        ClockSignal(cd=clkSig)

        # Input Signals
        self.qVector = Signal(14)
        self.reset = Signal()
        self.pllLocked = Signal()
        self.modeSelected = Signal()
        self.startProcess = Signal()

        # Output Signals
        self.bitslip = Signal()
        self.allignmentDone = Signal()

        # FSM Frame Aux Signals
        self.totalFrameCounter = Signal(3)
        self.bitslipEnable = Signal()
        self.countingFinished = Signal()

        # Clock Synchronous Check
        # Frame Allignment Process
        # Clock usage to modify bitslip values
        self.sync.invBufrFrameClk += [
            If(self.bitslipEnable,
                self.totalFrameCounter.eq(self.totalFrameCounter + 1),
                self.countingFinished.eq(0),
                If(self.totalFrameCounter == 5,
                    self.totalFrameCounter.eq(0),
                    #self.bitslipEnable.eq(0)
                    self.countingFinished.eq(1)
                )
            )
        ]
        
        # Frame Allignment FSM
        FrameAllign = FSM(reset_state="StartResetFrame")  
        self.submodules += FrameAllign

        # States Definition
        FrameAllign.act("StartResetFrame",
            self.allignmentDone.eq(0),
            #self.totalFrameCounter.eq(0),
            #self.bitslip.eq(0), 
            If((self.pllLocked & self.startProcess & (~self.modeSelected)),
                NextState("CheckFrame")
            )
        )
        FrameAllign.act("CheckFrame",
            #If(self.bitslipEnable == 0,
            self.bitslipEnable.eq(0),
            If(self.qVector == 16256,
                NextState("EndStandbyFrame")
            ).Else(
                NextState("ExecuteBitslip")
                 #   NextValue(self.bitslipEnable, 1)
            )
            #)            
        )
        FrameAllign.act("ExecuteBitslip",
            self.bitslipEnable.eq(1),
            If(self.countingFinished,
                NextState("CheckFrame")
            )
        )
        FrameAllign.act("EndStandbyFrame",
            If(self.reset,
                NextState("StartResetFrame")
            ).Else(
                self.allignmentDone.eq(1)
            )
        )

        # Combinatorial Output for Bitslip
        self.comb += [
            Case(self.totalFrameCounter, {
                0: self.bitslip.eq(0),
                1: self.bitslip.eq(1),
                2: self.bitslip.eq(0),
                3: self.bitslip.eq(0),
                4: self.bitslip.eq(0),
                5: self.bitslip.eq(0),
                "default": self.bitslip.eq(0),    
            })
        ]