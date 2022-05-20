#!/usr/bin/env python3

from migen import *
from migen.fhdl import verilog # Tal vez comentar
from litedram.common import *
from migen.genlib.fsm import FSM # Tal vez comentar

class FSMBit (Module):
    def __init__(self, clkSig="sys"):
        # Clock Domain Specification
        ClockSignal(cd=clkSig)

        # Input Signals
        self.qVector = Signal(14)
        self.locked = Signal()
        self.reset = Signal()
        self.modeSelected = Signal()
        self.startProcess = Signal()

        # Output Signals
        self.phaseCounter = Signal(2)
        self.finished = Signal()

        # FSM Aux Signals
        self.fallEdgeCounter = Signal(3)
        self.counterFlag = Signal()

        # Clock Synchronous Check
        # Bit Allignment Process
        # Clock usage to modify mux Control values
        self.sync.invMuxClk += [
            self.fallEdgeCounter.eq(self.fallEdgeCounter + 1),
            If(self.fallEdgeCounter == 7,
                self.fallEdgeCounter.eq(0),
                self.counterFlag.eq(1)
            ).Else(
                self.counterFlag.eq(0)
            )
        ]

        # Bit Allignment FSM
        BitAllign =  FSM(reset_state="StartReset")
        self.submodules += BitAllign

        # States Definition
        BitAllign.act("StartReset",
            self.finished.eq(0),
            If((self.locked & self.modeSelected & self.startProcess),
                NextState("CheckPhase")
            )
        )
        BitAllign.act("CheckPhase",
            If(self.counterFlag,
                If((self.qVector == 10922 or self.qVector == 5461),
                    NextState("EndStandby")
                ).Else(
                    NextValue(self.phaseCounter, self.phaseCounter + 1),
                    If(self.phaseCounter == 3,
                        NextState("EndStandby")
                    )
                )
            )
        )
        BitAllign.act("EndStandby",
            If(self.reset,
                NextState("StartReset")
            ).Else(
                self.finished.eq(1),
            )
        )