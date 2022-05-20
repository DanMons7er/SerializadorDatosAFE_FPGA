#!/usr/bin/env python3

from migen import *
from litedram.common import *

class DifferentialBuffer (Module):
    def __init__(self):
        # Signals
        self.inP = Signal()
        self.inN = Signal()

        # Outs
        self.O = Signal()

        # Instance
        self.diffBuffer = Instance("IBUFDS",
            i_I = self.inP,
            i_IB = self.inN,
            o_O = self.O)

        self.specials += self.diffBuffer

class BUFG (Module):
    def __init__(self):
        # Signals
        self.input = Signal()

        # Outs
        self.O = Signal()
        
        # Instance
        self.buffG = Instance("BUFG",
            i_I = self.input,
            o_O = self.O)
        
        self.specials += self.buffG

class BuffR (Module):
    def __init__(self, Mode="BYPASS"):
        # Signals
        self.input = Signal()
        
        # Outs
        self.O = Signal()

        # Instance
        self.buffR = Instance("BUFR",
            p_BUFR_DIVIDE = Mode,
            p_SIM_DEVICE = "7SERIES",
            i_I = self.input,
            i_CE = 1,
            i_CLR = 0,
            o_O = self.O)
        
        self.specials += self.buffR

class Obuf (Module):
    def __init__(self):
        # Signals
        self.input = Signal()

        # Outputs
        self.O = Signal()

        # Instance
        self.obuf = Instance("OBUF",
            p_DRIVE = 12,
            p_IOSTANDARD = "LVCMOS33",
            p_SLEW = "FAST",
            i_I = self.input,
            o_O = self.O)

        self.specials += self.obuf

class ODDR (Module):
    def __init__(self, CD="sys"):
        # Signals
        self.clock = ClockSignal(cd=CD)

        # Outputs
        self.clkOutput = Signal()

        # Instance
        self.oddr = Instance("ODDR",
            p_DDR_CLK_EDGE = "OPPOSITE_EDGE",
            p_INIT = 0,
            p_SRTYPE = "SYNC",
            i_C = self.clock,
            i_CE = 1,
            i_D1 = 1,
            i_D2 = 0,
            i_R = 0,
            i_S = 0,
            o_Q = self.clkOutput)
        
        self.specials += self.oddr