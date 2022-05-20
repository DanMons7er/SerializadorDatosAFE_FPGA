#!/usr/bin/env python3

from ctypes import pointer
from fcntl import I_CANPUT
from migen import *
from litedram.common import *
from litedram.phy.dfi import *

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
        self.emtpy = Signal()
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
