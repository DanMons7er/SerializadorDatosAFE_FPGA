#!/usr/bin/env python3

from migen import *
from migen.fhdl import verilog # Tal vez comentar
from litedram.common import *
from migen.genlib.fsm import FSM # Tal vez comentar

class FSMReadFIFO (Module):
    def __init__(self):
        # Inputs
        self.fifoAlmostEmptyFlag = Signal()
        self.fifoEmptyFlag = Signal()
        self.extReadEnable = Signal()
        self.fifordError = Signal()

        # Outputs
        self.enableReadingFIFO = Signal()
        self.readError = Signal()

        # Writing to a FIFO FSM Controller
        ReadFromFIFO = FSM(reset_state="Idle")
        self.submodules += ReadFromFIFO

        # States Definition
        ReadFromFIFO.act("Idle",
            self.enableReadingFIFO.eq(0),
            If(((~self.fifoEmptyFlag) & self.extReadEnable),
                self.enableReadingFIFO.eq(1),
                NextState("Read")
            ),
            If(self.fifordError | (self.fifoEmptyFlag & self.extReadEnable),
                NextState("Error")
            )
        )
        ReadFromFIFO.act("Read",
            self.enableReadingFIFO.eq(1),
            If(self.fifoEmptyFlag | (~self.extReadEnable),
                self.enableReadingFIFO.eq(0),
                NextState("Idle")
            )
        )
        ReadFromFIFO.act("Error",
            self.enableReadingFIFO.eq(0),
            self.readError.eq(1),
            If(~self.extReadEnable,
                NextState("Idle")
            )
        )