----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2021 19:51:41
-- Design Name: 
-- Module Name: SERDES - Behavioral
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
library UNISIM;
use UNISIM.VComponents.all;

entity SerDes is
  Port ( D: in std_logic;
         CLK: in std_logic;
         CLKDIV: in std_logic;
         Q1: out std_logic;
         Q2: out std_logic;
         Q3: out std_logic;
         Q4: out std_logic;
         Q5: out std_logic;
         Q6: out std_logic;
         Q7: out std_logic;
         Q8: out std_logic;
         SHIFTOUT1: out std_logic;
         SHIFTOUT2: out std_logic);
end SerDes;

architecture Behavioral of SerDes is

begin

end Behavioral;
