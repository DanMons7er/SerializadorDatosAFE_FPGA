----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2021 00:30:49
-- Design Name: 
-- Module Name: MUX4 - Behavioral
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


library UNISIM;
use UNISIM.VComponents.all;

entity MUX4 is
    Port ( In1 : in STD_LOGIC;
           In2 : in STD_LOGIC;
           In3 : in STD_LOGIC;
           In4 : in STD_LOGIC;
           S : in STD_LOGIC_VECTOR(1 downto 0);
           O : out STD_LOGIC);
end MUX4;

architecture Behavioral of MUX4 is
--Components
component MUX2 is
    Port ( In1 : in STD_LOGIC;
           In2 : in STD_LOGIC;
           S : in STD_LOGIC;
           O : out STD_LOGIC);
end component;

signal OA: std_logic;
signal OB: std_logic;

begin

    MuxA_ints: Mux2 Port map (In1, In2, S(0), OA);
    MuxB_ints: Mux2 Port map (In3, In4, S(0), OB);
    MuxC_ints: Mux2 Port map (OA, OB, S(1), O);
    
    

end Behavioral;
