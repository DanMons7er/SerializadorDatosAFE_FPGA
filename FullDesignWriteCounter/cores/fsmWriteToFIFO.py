#!/usr/bin/env python3

from migen import *
from migen.fhdl import verilog # Tal vez comentar
from litedram.common import *
from migen.genlib.fsm import FSM # Tal vez comentar

class FSMWriteFIFO (Module):
    def __init__(self):
        # Inputs
        self.fifoAlmostFullFlag = Signal()
        self.extWriteEnable = Signal()
        self.fifowrError = Signal()
        self.dataReady = Signal() 

        # Outputs
        self.enableWritingFIFO = Signal()
        self.writeError = Signal()

        # Writing to a FIFO FSM Controller
        WriteToFIFO = FSM(reset_state="Idle")
        self.submodules += WriteToFIFO

        # States Definition
        WriteToFIFO.act("Idle",
            self.enableWritingFIFO.eq(0),
            If(((~self.fifoAlmostFullFlag) & self.extWriteEnable & self.dataReady),
                self.enableWritingFIFO.eq(1),
                NextState("Write")
            ),
            If(self.fifowrError | (self.fifoAlmostFullFlag & self.extWriteEnable),
                NextState("Error")
            )
        )
        WriteToFIFO.act("Write",
            self.enableWritingFIFO.eq(1),
            If(self.fifoAlmostFullFlag | (~self.extWriteEnable),
                self.enableWritingFIFO.eq(0),
                NextState("Idle")
            )
        )
        WriteToFIFO.act("Error",
            self.enableWritingFIFO.eq(0),
            self.writeError.eq(1),
            If(~self.extWriteEnable,
                NextState("Idle")
            )
        )