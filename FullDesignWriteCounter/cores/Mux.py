#!/usr/bin/env python3

from migen import *
from litedram.common import *

class MuxInstance (Module):
    def __init__(self):
        # Signals
        self.phase = Signal(4)
        self.muxCtrl = Signal(2)
        self.OA = Signal()
        self.OB = Signal()

        # Outs
        self.OC = Signal()        

        # Instances
        self.MuxA = Instance("BUFGMUX_CTRL",
            i_I0 = self.phase[0],
            i_I1 = self.phase[1],
            i_S = self.muxCtrl[0],
            o_O = self.OA)

        self.MuxB = Instance("BUFGMUX_CTRL",
            i_I0 = self.phase[2],
            i_I1 = self.phase[3],
            i_S = self.muxCtrl[0],
            o_O = self.OB)

        self.MuxC = Instance("BUFGMUX_CTRL",
            i_I0 = self.OA,
            i_I1 = self.OB,
            i_S = self.muxCtrl[1],
            o_O = self.OC)
        
        self.specials += self.MuxA, self.MuxB, self.MuxC