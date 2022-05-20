----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.04.2021 15:30:15
-- Design Name: 
-- Module Name: CLK_RETRIEVER - Behavioral
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

entity CLK_RETRIEVER is
    Port( InPll: in std_logic;
          p0: out std_logic;
          p1: out std_logic;
          p2: out std_logic;
          p3: out std_logic);
end CLK_RETRIEVER;

architecture Behavioral of CLK_RETRIEVER is
--Components
component Buff is
    port( buffIn: in std_logic;
          buffOut: out std_logic);
end component;

component PLL is
    Port ( clkIn: in STD_LOGIC; --Clock in
           feedbackIn: in STD_LOGIC; 
           p0: out STD_LOGIC; --Phase 0
           p1: out STD_LOGIC; --Phase 1
           p2: out STD_LOGIC; --Phase 2
           p3: out STD_LOGIC; --Phase 3
           feedbackOut: out STD_LOGIC);
end component;

--PLL Signals
signal feedbackIn: std_logic;
signal feedbackOut: std_logic;
signal p0Out: std_logic;
signal p1Out: std_logic;
signal p2Out: std_logic;
signal p3Out: std_logic;


begin

        -- Feedback Buffers Instatiation                        
    BuffFB_inst: Buff PORT MAP (feedbackOut, feedbackIn);
    
    --PLL Instatiation
    PLL_inst: PLL PORT MAP (inPll,
                            feedbackIn,
                            p0Out,
                            p1Out,
                            p2Out,
                            p3Out,
                            feedbackOut);
    
    --Phases Buffers Instatiation
    BuffPhase0_inst: Buff PORT MAP (p0Out, p0);
    BuffPhase1_inst: Buff PORT MAP (p1Out, p1);
    BuffPhase2_inst: Buff PORT MAP (p2Out, p2);
    BuffPhase3_inst: Buff PORT MAP (p3Out, p3);
    

end Behavioral;
