----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.07.2021 08:42:23
-- Design Name: 
-- Module Name: Led - Behavioral
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

entity Led is
  Port (sw1: in std_logic;
        sw2: in std_logic;
        sw3: in std_logic;
        led1: out std_logic;
        led2: out std_logic;
        led3: out std_logic);
end Led;

architecture Behavioral of Led is

begin

led1 <= sw1;

led2 <= sw2;

led3 <= sw3;


end Behavioral;
