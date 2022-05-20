----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.04.2021 11:27:56
-- Design Name: 
-- Module Name: bitAlignment - Behavioral
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

entity bitAlignment is
    Port (  inputClk:    in std_logic;
            inputFrame:  in std_logic;
            modChange:   in boolean;
            muxControl:  out std_logic_vector (2 downto 0);
            Ph1Works :   out boolean);
end bitAlignment;

architecture Behavioral of bitAlignment is

type fm_State is (Ph1, StandBy);
signal State :          fm_State := Ph1;    
signal bitsReceivedR :  integer range 0 to 6 := 0;
signal bitsReceivedF :  integer range 0 to 6 := 0;
signal counterU :       integer range 0 to 13 := 1;
signal MSB :            integer range 1 to 2 := 1;
signal counterD :       integer range 0 to 13 := 13;
signal Flag1 :          boolean := False;
signal frame :          std_logic_vector (13 downto 0) := "00000000000000";

begin

    --Change State Process
    process(State, bitsReceivedR, bitsReceivedF, modChange) begin
        case (State) is
            when  Ph1 => if (bitsReceivedR+bitsReceivedF < 13) then
                            State <= Ph1;
                         elsif (bitsReceivedR+bitsReceivedF = 13) then
                            State <= StandBy;                      
                         end if;
            when  StandBy => if (modChange = TRUE) then
                            State <= Ph1;
                            Flag1 <= FALSE;
                         elsif (modChange = FALSE) then
                            State <= StandBy;
                         end if;                                                                                                                          
        end case;
    end process;
    
    --Mux Control Update Process
    process (State) begin
        case(State) is 
            when Ph1 => muxControl <= "000";
            when StandBy => muxControl <= "001";
        end case;  
    end process;
    
    --Falling Edge Process
    process (State, inputClk, bitsReceivedF, bitsReceivedR, frame, Flag1) begin 
        case (State) is
            when Ph1 => if falling_edge(inputClk) then
                            bitsReceivedF <= bitsReceivedF + 1; -- This tells how many bits have been read
                            if (MSB = 1) then
                                frame(counterU) <= inputFrame;
                                counterU <= counterU + 1; -- This also works for msb counter
                            elsif (MSB = 2) then
                                frame(counterD) <= inputFrame;
                                counterD <= counterD - 1; -- This is for the alternative order of the msb
                            end if;                               
                        end if;
                        if (bitsReceivedR+bitsReceivedF = 13) then
                            if (frame = "10101010101010") then
                                Flag1 <= TRUE;
                                frame <= "00000000000000"; -- frame vector must be reset
                                -- counters must also be reset
                                counterU <= 0;
                                counterD <= 13;
                                bitsReceivedF <= 0; -- Restarts quantity of bits received
                            else 
                                Flag1 <= FALSE;
                                frame <= "00000000000000"; -- frame vector must be reset
                                -- counters must also be reset
                                counterU <= 0;
                                counterD <= 13;
                                bitsReceivedF <= 0; -- Restarts quantity of bits received
                            end if;
                        end if;
            when StandBy => Ph1Works <= Flag1;                                                                                                                                                              
        end case;
    end process;
    
--    --Rising Edge Process
    process (State, inputClk, bitsReceivedR, bitsReceivedF, frame, Flag1) begin 
        case (State) is
            when Ph1 => if rising_edge(inputClk) then
                            bitsReceivedR <= bitsReceivedR + 1; -- This tells how many bits have been read
                            if (MSB = 1) then
                                frame(counterU) <= inputFrame;
                                counterU <= counterU + 1; -- This also works for msb counter
                            elsif (MSB = 2) then
                                frame(counterD) <= inputFrame;
                                counterD <= counterD - 1; -- This is for the alternative order of the msb
                            end if;                               
                        end if;
                        if (bitsReceivedR+bitsReceivedF = 13) then
                            if (frame = "10101010101010") then
                                Flag1 <= TRUE;
                                frame <= "00000000000000"; -- frame vector must be reset
                                -- counters must also be reset
                                counterU <= 0;
                                counterD <= 13;
                                bitsReceivedR <= 0; -- Restarts quantity of bits received
                            else 
                                Flag1 <= FALSE;
                                frame <= "00000000000000"; -- frame vector must be reset
                                -- counters must also be reset
                                counterU <= 0;
                                counterD <= 13;
                                bitsReceivedR <= 0; -- Restarts quantity of bits received
                            end if;
                        end if;
            when StandBy => Ph1Works <= Flag1;                                                                                                                                                              
        end case;
    end process;
    
    
end Behavioral;