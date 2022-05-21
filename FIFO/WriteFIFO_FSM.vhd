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

entity WriteFIFO_FSM is
    port ( --Frame_Clk: in std_logic;
           --FIFO_AlmostFull: in std_logic;
           FIFO_Full: in std_logic;
           Wr_Error: in std_logic;
           Wr_Enable: out std_logic
         );
end WriteFIFO_FSM;

architecture Behavioral of WriteFIFO_FSM is

begin
Stop:   process (FIFO_Full)
begin
    if (Wr_Error = '0') then
        if (FIFO_Full = '1') then
            Wr_Enable <= '0';
        end if;
        if (FIFO_Full = '0') then
            Wr_Enable <= '1';
        end if;
    end if;
end process Stop;
end Behavioral;