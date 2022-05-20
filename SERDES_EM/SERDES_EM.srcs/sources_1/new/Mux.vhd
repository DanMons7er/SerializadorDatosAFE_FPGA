----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.04.2021 11:20:53
-- Design Name: 
-- Module Name: Mux - Behavioral
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


Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux is
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
end Mux;

architecture Behavioral of Mux is

begin
    process (MuxControl, p0, p1, p2, p3, p4, p5, p6, p7)
    begin
        case (MuxControl) is
            when "000" => HypCLK <= p0;
            when "001" => HypCLK <= p1;
            when "010" => HypCLK <= p2;
            when "011" => HypCLK <= p3;
            when "100" => HypCLK <= p4;
            when "101" => HypCLK <= p5;
            when "110" => HypCLK <= p6;
            when "111" => HypCLK <= p7;
        end case;
    end process;
end Behavioral;
