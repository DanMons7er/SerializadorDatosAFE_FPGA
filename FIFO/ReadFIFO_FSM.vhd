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

entity ReadFIFO_FSM is
    port ( Frame_Clk: in std_logic;
           Read_Clk: in std_logic;
           --FIFO_AlmostEmpty: in std_logic;
           FIFO_Empty: in std_logic;
           RST_BTNC: in std_logic;
           Rd_Error: in std_logic;
           Rd_Enable: out std_logic
         );
end ReadFIFO_FSM;

architecture Behavioral of ReadFIFO_FSM is
--type States is (ReadFromFIFO, Idle);
--signal State, S_State: States;
--signal WReset: std_logic := '0';
signal SampleCounter: integer range 0 to 19500 := 0;
signal ReadSampleCounter: integer range 0 to 19500 := 0;

begin
Reset:  process(RST_BTNC)
begin
    if (RST_BTNC = '1') then
        SampleCounter <= 0;
        ReadSampleCounter <= 0;
        Rd_Enable <= '0';
--        State <= Idle;
--        WReset <= '1';
--    elsif rising_edge(BIT_CLK) then
--        State <= S_State;
--        WReset <= '0';
    end if;
end process Reset;

Read_Check:   process(Frame_Clk, SampleCounter, FIFO_Empty)
begin    
    if (Rd_Error = '0') then
        if rising_edge(Frame_Clk) then
            SampleCounter <= SampleCounter + 1;
        end if;
        if (FIFO_Empty = '1') then
            Rd_Enable <= '0';
        elsif (SampleCounter = 19500) then 
            --if (FIFO_Empty = '0') then 
            Rd_Enable <= '1';
            --end if;
            SampleCounter <= 0;
        end if;        
    end if;
end process Read_Check;

Read_Stop: process(Read_Clk, ReadSampleCounter)
begin
    if (rising_edge(Read_Clk) AND Rd_Enable = '1') then
        ReadSampleCounter <= ReadSampleCounter + 1;
    end if;
    if (ReadSampleCounter = 19500) then
        Rd_Enable <= '0';
        ReadSampleCounter <= 0;
    end if;
end process Read_Stop;
end Behavioral;