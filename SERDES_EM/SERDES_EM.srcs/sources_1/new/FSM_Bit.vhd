----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.05.2021 23:48:27
-- Design Name: 
-- Module Name: FSM_Bit - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM_Bit is
    Port ( BitClk : in std_logic;
           Q1 : in std_logic;
           Q2 : in std_logic;
           Q3 : in std_logic;
           Q4 : in std_logic;
           Q5 : in std_logic;
           Q6 : in std_logic;
           Q7 : in std_logic;
           Q8 : in std_logic;
           Q9 : in std_logic;
           Q10 : in std_logic;
           Q11 : in std_logic;
           Q12 : in std_logic;
           Q13 : in std_logic;
           Q14 : in std_logic; 
           FCLK_INT_R : in std_logic;
           RST_BTNC : in std_logic;
           MControl : out STD_LOGIC_VECTOR(1 downto 0);
           FSM_BitReady : out std_logic
          );
end FSM_Bit;

architecture Behavioral of FSM_Bit is
type States is (PhaseAlligned, PhaseSelector);
signal State, S_State: States;
signal WReset: std_logic := '0';
signal Aux_Register: std_logic_vector(13 downto 0) := "00000000000000";
signal FallEdgeCounter: integer range 0 to 7 := 0;
signal PhaseReady: std_logic := '0';
signal PhaseCounter: integer range 0 to 3 := 0;
signal DataAlligned: std_logic := '0';
signal AuxData: std_logic := '0';

begin
Synch:  process(FCLK_INT_R,RST_BTNC) -- Comment the CLK if the rising_edge is also commented
begin
    if (RST_BTNC = '1') then
        State <= PhaseAlligned;
        WReset <= '1';
    elsif rising_edge(FCLK_INT_R) then
    -- Comment the rising_edge if having issues with defining the state
        State <= S_State;
        WReset <= '0';
    end if;
end process Synch;

Comb:   process(State,FCLK_INT_R,AuxData,WReset,DataAlligned,PhaseCounter,AuxData,BitClk,FallEdgeCounter,Aux_Register,PhaseReady,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14)
begin
    case State is
        when PhaseAlligned =>
            if rising_edge(FCLK_INT_R) then
            -- The FSM verifies if the system was reset or not
                if (WReset = '1') then
                    Aux_Register <= "00000000000000";
                    FallEdgeCounter <= 0;  
                    PhaseCounter <= 0;  
                    PhaseReady <= '0';                    
                    AuxData <= '0'; 
                    DataAlligned <= '0';
                    FSM_BitReady <= '0';
                elsif (WReset = '0') then
                    if (DataAlligned = '0') then
                    -- If data is not alligned, then we must change state
                        AuxData <= '0';
                        Aux_Register <= "00000000000000";
                        FSM_BitReady <= '0';
                    elsif (DataAlligned = '1') then
                    -- The work for this machine is done, it is sent to the other machine ir order to allign the frame
                        AuxData <= '1';
                        FSM_BitReady <= '1';
                        -- Let's use a proper clock
                        case PhaseCounter is 
                            when 0 =>   MControl <= "00";
                            when 1 =>   MControl <= "01";
                            when 2 =>   MControl <= "10";
                            when 3 =>   MControl <= "11";
                        end case; 
                    end if;
                end if;
            end if;    
            -- Verification of the state
            if (AuxData = '0') then
                S_State <= PhaseSelector;
            else 
                S_State <= PhaseAlligned;
            end if;
            
        when PhaseSelector =>
            -- The Mux is changed first
            case PhaseCounter is 
                when 0 =>   MControl <= "00";
                when 1 =>   MControl <= "01";
                when 2 =>   MControl <= "10";
                when 3 =>   MControl <= "11";
            end case;                
            if falling_edge(BitClk) then
                FallEdgeCounter <= FallEdgeCounter + 1;
            end if;
            -- Data is then stored
            Aux_Register(13) <= Q1;
            Aux_Register(12) <= Q2;
            Aux_Register(11) <= Q3;
            Aux_Register(10) <= Q4; 
            Aux_Register(9) <= Q5;
            Aux_Register(8) <= Q6;
            Aux_Register(7) <= Q7; 
            Aux_Register(6) <= Q8;
            Aux_Register(5) <= Q9;
            Aux_Register(4) <= Q10;
            Aux_Register(3) <= Q11;
            Aux_Register(2) <= Q12;
            Aux_Register(1) <= Q13;
            Aux_Register(0) <= Q14;
            if (FallEdgeCounter = 7) then
                FallEdgeCounter <= 0;
                -- We check if the data is the one we need, else this phase is no good
                if (Aux_Register = "10101010101010" OR Aux_Register = "01010101010101") then
                    -- This phase works!                    
                    PhaseReady <= '1';
                    DataAlligned <= '1';
                else
                    -- It did not  
                    if (PhaseCounter = 3) then  
                    -- Re start just in case, if no phase works, so that the system doens't stay in an infinite loop
                        PhaseCounter <= 0;
                        PhaseReady <= '1';
                        DataAlligned <= '1';
                    else
                        PhaseCounter <= PhaseCounter + 1;                         
                        PhaseReady <= '0';
                        DataAlligned <= '0';
                    end if;             
                end if;
            end if;
            -- Verification of the state
            if (PhaseReady = '0') then
                S_State <= PhaseSelector;
            else 
                S_State <= PhaseAlligned;
            end if;            
        
    end case;
end process Comb;

end Behavioral;
