#!/usr/bin/env python3

from migen import *
from litedram.common import *

class ISerDeseMaster (Module):
    def __init__(self, InterfaceType="NETWORKING", InitVal=0):
        # Input Signals
        self.BitslipInput = Signal()
        self.InputClk = Signal()
        self.InvertedInputClk = Signal()
        self.DividedClk = Signal()
        self.DataInput = Signal()
        self.Reset = Signal()

        # Internal Signals
        self.output = Signal()

        # Outputs
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
            o_O = self.output,
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

        # Internal Signals
        self.output = Signal()
        self.unusedQ1 = Signal()
        self.unusedQ2 = Signal()
        self.unusedShift1 = Signal()
        self.unusedShift2 = Signal()

        # Outputs
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
            o_O = self.output,
            o_Q1 = self.unusedQ1,
            o_Q2 = self.unusedQ2,
            o_Q3 = self.QVector[0],
            o_Q4 = self.QVector[1],
            o_Q5 = self.QVector[2],
            o_Q6 = self.QVector[3],
            o_Q7 = self.QVector[4],
            o_Q8 = self.QVector[5],
            o_SHIFTOUT1 = self.unusedShift1,
            o_SHIFTOUT2 = self.unusedShift2,
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

class ISerDese (Module):
    def __init__(self, InClk="sys", InvClk="sys", DivClk="sys"):
        # Input Signals
        self.mainBitslipInput = Signal()
        self.inputClock = ClockSignal(cd=InClk)
        self.invInputClock = ClockSignal(cd=InvClk)
        self.dividedClock = ClockSignal(cd=DivClk)
        self.mainDataInput = Signal()
        self.mainReset = Signal()

        # Output Signals
        self.mainQVector = Signal(14)

        # ISERDESE Modules Declaration
        MasterISerDese = ISerDeseMaster()
        SlaveISerDese = ISerDeseSlave()
        self.submodules += [
            MasterISerDese,
            SlaveISerDese
        ]

        # Connections (Inputs)
        self.comb += [
            MasterISerDese.BitslipInput.eq(self.mainBitslipInput),
            SlaveISerDese.BitslipInput.eq(self.mainBitslipInput),
            MasterISerDese.InputClk.eq(self.inputClock),
            SlaveISerDese.InputClk.eq(self.inputClock),
            MasterISerDese.InvertedInputClk.eq(self.invInputClock),
            SlaveISerDese.InvertedInputClk.eq(self.invInputClock),
            MasterISerDese.DividedClk.eq(self.dividedClock),
            SlaveISerDese.DividedClk.eq(self.dividedClock),
            MasterISerDese.DataInput.eq(self.mainDataInput),
            SlaveISerDese.DataInput.eq(0),
            MasterISerDese.Reset.eq(self.mainReset),
            SlaveISerDese.Reset.eq(self.mainReset)
        ]

        # Connections (Internal)
        self.comb += [
            SlaveISerDese.shift.eq(MasterISerDese.shift)
        ]

        # Connections (Output)
        # Q_Vector Generation
        for i in range(8):
            self.comb += self.mainQVector[i].eq(MasterISerDese.QVector[i])
        for i in range(6):
            self.comb += self.mainQVector[i+8].eq(SlaveISerDese.QVector[i])