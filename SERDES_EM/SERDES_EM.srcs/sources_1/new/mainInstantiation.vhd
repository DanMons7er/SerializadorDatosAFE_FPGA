----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.04.2021 10:11:09
-- Design Name: 
-- Module Name: mainInstantiation - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mainInstantiation is
    Port ( inputClockP: in std_logic;   -- Diff_p buffer input for for the bit clock
           inputClockN: in std_logic;   -- Diff_n buffer input for for the bit clock       
           frameInputP: in std_logic;    -- Input P Frame from AFE
           frameInputN: in std_logic;    -- Input N Frame from AFE
--           modChange: in boolean :=FALSE;
           MuxControl: in std_logic_vector (2 downto 0);
           HypClk: out std_logic);
           --Ph1Works : out boolean := FALSE);    --Led of Nexys
           
end mainInstantiation;

architecture Behavioral of mainInstantiation is

--COMPONENTS
component diffBuff is 
    port( buffInP: in std_logic;
          buffInN: in std_logic;
          buffOut: out std_logic);
end component;

component CLK_RETRIEVER is
    Port( InPll: in std_logic;
          p0: out std_logic;
          p1: out std_logic;
          p2: out std_logic;
          p3: out std_logic;
          p4: out std_logic;
          p5: out std_logic;
          p6: out std_logic;
          p7: out std_logic);
end component;

component Mux is
    port( p0: in std_logic;  -- CLKOUT0_PLL
          p1: in std_logic;  -- CLKOUT1_PLL
          p2: in std_logic;  -- CLKOUT2_PLL
          p3: in std_logic;  -- CLKOUT3_PLL
          p4: in std_logic;  -- CLKOUT4_PLL
          p5: in std_logic;  -- CLKOUT5_PLL
          p6: in std_logic;  -- CLKOUT0_MMCM
          p7: in std_logic;  -- CLKOUT1_MMCM
          MuxControl: in std_logic_vector (2 downto 0);
          HypCLK: out std_logic); --Hypothetical Clock
end component;

component bitAlignment is 
    Port ( inputClk:    in std_logic;
           inputFrame:  in std_logic;
           modChange:   in boolean;
           muxControl:  out std_logic_vector (2 downto 0) := "000";
           Ph1Works :   out boolean);
end component;

--SIGNALS
--Diffential Buff Signals
signal dfBfClkOut: std_logic;
signal dfBfFrameOut: std_logic;

--ClK Retriever Signals
signal p0: std_logic;
signal p1: std_logic;
signal p2: std_logic;
signal p3: std_logic;
signal p4: std_logic;
signal p5: std_logic;
signal p6: std_logic;
signal p7: std_logic;

--Mux Signals
--signal HypClk: std_logic;
--signal MuxControl: std_logic_vector (2 downto 0);

--State Machine Signals
--signal modChange: boolean := FALSE;

begin
    --Diffential Buff Instatiation For  Clock 
    DfBfCLK_inst: diffBuff PORT MAP (inputClockP,
                                     inputClockN,
                                     dfBfClkOut);
    
    --Diffential Buff Instatiation For Frame
    DfBfFrame_inst: diffBuff PORT MAP (frameInputP,
                                       frameInputN,
                                       dfBfFrameOut);
    
    --Clk Retriever Instantiation
    Retriever_inst: CLK_RETRIEVER PORT MAP (dfBfClkOut,
                                            p0,
                                            p1,
                                            p2,
                                            p3,
                                            p4,
                                            p5,
                                            p6,
                                            p7);
    
--    --State Machine Instantiation
--    SM_Bits: bitAlignment PORT MAP (HypClk,
--                                    dfBfFrameOut,
--                                    modChange,
--                                    muxControl,
--                                    Ph1Works);
    
    --Mux Instatiation
    Mux_inst: Mux PORT MAP (p0,
                            p1,
                            p2,
                            p3,
                            p4,
                            p5,
                            p6,
                            p7,
                            MuxControl,
                            HypClk);

                              
end Behavioral;