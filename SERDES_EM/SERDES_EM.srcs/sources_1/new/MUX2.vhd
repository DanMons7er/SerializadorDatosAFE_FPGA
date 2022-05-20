----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2021 19:43:40
-- Design Name: 
-- Module Name: MUX2 - Behavioral
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

entity MUX2 is
    Port ( In1 : in STD_LOGIC;
               In2 : in STD_LOGIC;
               S : in STD_LOGIC;
               O : out STD_LOGIC);
end MUX2;

architecture Behavioral of MUX2 is
begin
    
   BUFGMUX_CTRL_inst : BUFGMUX_CTRL
   port map (
      O => O,   -- 1-bit output: Clock output
      I0 => In1, -- 1-bit input: Clock input (S=0)
      I1 => In2, -- 1-bit input: Clock input (S=1)
      S => S    -- 1-bit input: Clock select
   );

end Behavioral;
