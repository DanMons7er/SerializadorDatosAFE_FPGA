#!/usr/bin/env python3

from migen import *
from litedram.common import *

class PllInstance (Module):
    def __init__(self, Multiplier, Divider, Period):
        # Signals
        self.Clk = Signal()
        self.Reset = Signal()

        #Outs
        self.phase = Signal(6)
        self.Locked = Signal()

        #Signals
        self.FeedbackClk = Signal()

        self.pll = Instance("PLLE2_BASE",
            p_BANDWIDTH = "OPTIMIZED",  
            p_CLKFBOUT_MULT = Multiplier, 
            p_CLKFBOUT_PHASE = 0, 
            p_CLKIN1_PERIOD = Period,
            p_CLKOUT0_DIVIDE = Multiplier, 
            p_CLKOUT1_DIVIDE = Multiplier, 
            p_CLKOUT2_DIVIDE = Multiplier, 
            p_CLKOUT3_DIVIDE = Multiplier, 
            p_CLKOUT4_DIVIDE = Multiplier, 
            p_CLKOUT5_DIVIDE = Multiplier,
            p_CLKOUT0_DUTY_CYCLE = 0.5,
            p_CLKOUT1_DUTY_CYCLE = 0.5,
            p_CLKOUT2_DUTY_CYCLE = 0.5,
            p_CLKOUT3_DUTY_CYCLE = 0.5,
            p_CLKOUT4_DUTY_CYCLE = 0.5,
            p_CLKOUT5_DUTY_CYCLE = 0.5,
            p_CLKOUT0_PHASE = 0.0,
            p_CLKOUT1_PHASE = 45,
            p_CLKOUT2_PHASE = 90,
            p_CLKOUT3_PHASE = 135,
            p_CLKOUT4_PHASE = 180,
            p_CLKOUT5_PHASE = 225,
            p_DIVCLK_DIVIDE = Divider,
            p_REF_JITTER1 = 0.0,
            p_STARTUP_WAIT = "FALSE",
            
            o_CLKOUT0 = self.phase[0],
            o_CLKOUT1 = self.phase[1],
            o_CLKOUT2 = self.phase[2],
            o_CLKOUT3 = self.phase[3],
            o_CLKOUT4 = self.phase[4],
            o_CLKOUT5 = self.phase[5],         
            o_CLKFBOUT = self.FeedbackClk,
            o_LOCKED = self.Locked,
            i_CLKIN1 = self.Clk,
            i_PWRDWN = 0,
            i_RST = self.Reset,
            i_CLKFBIN = self.FeedbackClk)

        self.specials += self.pll