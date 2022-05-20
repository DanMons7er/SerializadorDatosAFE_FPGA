#!/usr/bin/env python3

from migen import *
from litedram.common import *

class ISerDeseMaster (Module):
    def __init__(self, InterfaceType="NETWORKING", InitVal=0):
        # Signals
        self.BitslipInput = Signal()
        self.InputClk = Signal()
        self.InvertedInputClk = Signal()
        self.DividedClk = Signal()
        self.DataInput = Signal()
        self.Reset = Signal()

        # Outs
        self.QVector = Signal(8)
        self.shift = Signal(2)

        self.iserdeseMaster = Instance("ISERDESE2",
            p_DATA_RATE = "DDR",
            p_DATA_WIDTH = 14,
            p_DYN_CLKDIV_INV_EN = "FALSE",
            p_DYN_CLK_INV_EN = "FALSE",
            p_INIT_Q1 = InitVal,
            p_INIT_Q2 = InitVal,
            p_INIT_Q3 = InitVal,
            p_INIT_Q4 = InitVal,
            p_INTERFACE_TYPE = InterfaceType,
            p_IOBDELAY = "NONE",
            p_NUM_CE = 1,
            p_OFB_USED = "FALSE",
            p_SERDES_MODE = "MASTER",
            p_SRVAL_Q1 = 0,
            p_SRVAL_Q2 = 0,
            p_SRVAL_Q3 = 0,
            p_SRVAL_Q4 = 0,
            o_Q1 = self.QVector[0],
            o_Q2 = self.QVector[1],
            o_Q3 = self.QVector[2],
            o_Q4 = self.QVector[3],
            o_Q5 = self.QVector[4],
            o_Q6 = self.QVector[5],
            o_Q7 = self.QVector[6],
            o_Q8 = self.QVector[7],
            o_SHIFTOUT1 = self.shift[0],
            o_SHIFTOUT2 = self.shift[1],
            i_BITSLIP = self.BitslipInput,
            i_CE1 = 1,
            i_CLKDIVP = 0,
            i_CLK = self.InputClk,
            i_CLKB = self.InvertedInputClk,
            i_CLKDIV = self.DividedClk,
            i_OCLK = 0,
            i_DYNCLKDIVSEL = 0,
            i_DYNCLKSEL = 0,
            i_D = self.DataInput,
            i_DDLY = 0,
            i_OFB = 0,
            i_OCLKB = 0,
            i_RST = self.Reset,
            i_SHIFTIN1 = 0,
            i_SHIFTIN2 = 0),
        
        self.specials += self.iserdeseMaster

class ISerDeseSlave (Module):
    def __init__(self, InterfaceType="NETWORKING", InitVal=0):
        # Signals
        self.BitslipInput = Signal()
        self.InputClk = Signal()
        self.InvertedInputClk = Signal()
        self.DividedClk = Signal()
        self.DataInput = Signal()
        self.Reset = Signal()
        self.shift = Signal(2)

        #Outs
        self.QVector = Signal(6)

        self.iserdeseSlave = Instance("ISERDESE2",
            p_DATA_RATE = "DDR",
            p_DATA_WIDTH = 14,
            p_DYN_CLKDIV_INV_EN = "FALSE",
            p_DYN_CLK_INV_EN = "FALSE",
            p_INIT_Q1 = InitVal,
            p_INIT_Q2 = InitVal,
            p_INIT_Q3 = InitVal,
            p_INIT_Q4 = InitVal,
            p_INTERFACE_TYPE = InterfaceType,
            p_IOBDELAY = "NONE",
            p_NUM_CE = 1,
            p_OFB_USED = "FALSE",
            p_SERDES_MODE = "SLAVE",
            p_SRVAL_Q1 = 0,
            p_SRVAL_Q2 = 0,
            p_SRVAL_Q3 = 0,
            p_SRVAL_Q4 = 0,
            o_Q3 = self.QVector[0],
            o_Q4 = self.QVector[1],
            o_Q5 = self.QVector[2],
            o_Q6 = self.QVector[3],
            o_Q7 = self.QVector[4],
            o_Q8 = self.QVector[5],
            i_BITSLIP = self.BitslipInput,
            i_CE1 = 1,
            i_CLKDIVP = 0,
            i_CLK = self.InputClk,
            i_CLKB = self.InvertedInputClk,
            i_CLKDIV = self.DividedClk,
            i_OCLK = 0,
            i_DYNCLKDIVSEL = 0,
            i_DYNCLKSEL = 0,
            i_D = self.DataInput,
            i_DDLY = 0,
            i_OFB = 0,
            i_OCLKB = 0,
            i_RST = self.Reset,
            i_SHIFTIN1 = self.shift[0],
            i_SHIFTIN2 = self.shift[1]),
        
        self.specials += self.iserdeseSlave