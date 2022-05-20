----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.04.2021 10:31:14
-- Design Name: 
-- Module Name: Buff - Behavioral
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

Library UNISIM;
use UNISIM.vcomponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Buff is
    port( buffIn: in std_logic;
          buffOut: out std_logic);
end Buff;

architecture Behavioral of Buff is

begin
    BUFG_inst : BUFG
       port map (
          O => buffOut, -- 1-bit output: Clock output
          I => buffIn  -- 1-bit input: Clock input
       );

end Behavioral;
