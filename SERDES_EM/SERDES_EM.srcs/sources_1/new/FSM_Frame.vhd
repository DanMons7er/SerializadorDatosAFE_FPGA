----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.04.2021 21:01:01
-- Design Name: 
-- Module Name: FSM_Frame - Behavioral
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

entity FSM_Frame is
    Port ( Q1 : in std_logic;
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
           CLKDIV : in std_logic;
           BitAllignReady : in std_logic;
           showRegInLED : out std_logic_vector (0 to 7);
           bitslip_int : out std_logic
          );
end FSM_Frame;

architecture Behavioral of FSM_Frame is
type States is (NoOperation, ExecuteBitslip, CheckIfBitslip);
signal State, S_State: States;
signal NeedBitslip: std_logic := '0';
signal Register_Out: std_logic_vector (13 downto 0) := "00000000000000";
signal WasReset: std_logic := '0'; -- Flag that shows the system was reset
--signal FinalReg: std_logic_vector (13 downto 0) := "00000000000000"; -- Aux vector for the registers, to "keep memory"
--signal FinalLED: std_logic_vector (0 to 7) := "00000000"; -- Aux vector for the registers, to "keep memory"
signal Count_Fall_Edge_CLKDiv: integer range 0 to 5 := 0;
signal Wait1Cycle: std_logic := '0';
signal Wait2Cycle: std_logic := '0';
signal Wait3Cycle: std_logic := '0';
signal BitslipDone: std_logic := '0';
signal AuxData: std_logic := '0';
signal DataAlligned: std_logic := '0';

begin
Synch:  process(FCLK_INT_R,RST_BTNC) -- COmment the CLK if the rising_edge is also commented
begin
    if (RST_BTNC = '1') then
        State <= NoOperation;
        WasReset <= '1';
    elsif rising_edge(FCLK_INT_R) then
    -- Comment the rising_edge if having issues with defining the state
        State <= S_State;
        WasReset <= '0';
    end if;
end process Synch;

Comb:   process(State,FCLK_INT_R,WasReset,DataAlligned,BitAllignReady,AuxData,CLKDIV,Count_Fall_Edge_CLKDiv,BitslipDone,Register_Out,NeedBitslip,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14)
begin
    case State is
        when NoOperation =>
            if rising_edge(FCLK_INT_R) then
            -- The FSM verifies if the system was reset or not
                if (WasReset = '1') then
                    --Register_Out <= "00000000000000";
                    --showRegInLED <= "00000000";
                    --FinalReg <= "00000000000000";
                    --FinalLED <= "00000000";
                    DataAlligned <= '0';
                    AuxData <= '0';
                elsif (WasReset = '0') then
                    if (DataAlligned = '0') then
                        AuxData <= '0';
                        --Register_Out <= "00000000000000";
                        --showRegInLED <= "00000000";
                        --showRegInLED <= Q14 & Q7 & Q6 & Q5 & Q4 & Q3 & Q2 & Q1;
                    elsif (DataAlligned = '1') then
                    -- Keeps reading the data and shows it to the user since it is already alligned
                        AuxData <= '1';
                        --if rising_edge(FCLK_INT_R) then
                        Register_Out(13) <= Q1;
                        Register_Out(12) <= Q2;
                        Register_Out(11) <= Q3;
                        Register_Out(10) <= Q4; 
                        Register_Out(9) <= Q5;
                        Register_Out(8) <= Q6;
                        Register_Out(7) <= Q7; 
                        Register_Out(6) <= Q8;
                        Register_Out(5) <= Q9;
                        Register_Out(4) <= Q10;
                        Register_Out(3) <= Q11;
                        Register_Out(2) <= Q12;
                        Register_Out(1) <= Q13;
                        Register_Out(0) <= Q14;  
                        --end if; 
                        showRegInLED <= Q14 & Q7 & Q6 & Q5 & Q4 & Q3 & Q2 & Q1;
                    end if;                
                end if;
--                if (AuxData = '0' ) then --AND BitAllignReady = '1'
--                -- Must check if there are bitslips to perform, only way to acces later state
--                -- If the bit alligner finite state machine hasn't finished, this state machine won't start
--                    S_State <= CheckIfBitslip;
--                else
--                -- Means that data is alligned therefore no operation is needed
--                    S_State <= NoOperation;
--                end if;  
            end if;   
            if (AuxData = '0' AND BitAllignReady = '1') then --AND BitAllignReady = '1'
            -- Must check if there are bitslips to perform, only way to acces later state
            -- If the bit alligner finite state machine hasn't finished, this state machine won't start
                S_State <= CheckIfBitslip;
            else
            -- Means that data is alligned therefore no operation is needed
                S_State <= NoOperation;
            end if;     
            
        when ExecuteBitslip =>
        -- Let's generate a bitslip for the parallel data
            if falling_edge(CLKDIV) then
                Count_Fall_Edge_CLKDiv <= Count_Fall_Edge_CLKDiv + 1;   
                -- Let's do the bit slip case fucntion
                case Count_Fall_Edge_CLKDiv is
                    when 1 =>   bitslip_int <= '1';
                                Wait1Cycle <= '0';
                                Wait2Cycle <= '0';
                                Wait3CYcle <= '0';
                                BitslipDone <= '0';
                    when 2 =>   bitslip_int <= '0';
                                Wait1Cycle <= '1';
                                Wait2Cycle <= '0';
                                Wait3CYcle <= '0';
                                BitslipDone <= '0';
                    when 3 =>   bitslip_int <= '0';
                                Wait1Cycle <= '0';
                                Wait2Cycle <= '1';
                                Wait3CYcle <= '0';
                                BitslipDone <= '0';
                    when 4 =>   bitslip_int <= '0';
                                Wait1Cycle <= '0';
                                Wait2Cycle <= '0';
                                Wait3CYcle <= '1';
                                BitslipDone <= '0';
                    when 5 =>   bitslip_int <= '0';
                                Wait1Cycle <= '0';
                                Wait2Cycle <= '0';
                                Wait3CYcle <= '0';
                                BitslipDone <= '1';
                                Count_Fall_Edge_CLKDiv  <= 0;
                    when others =>   bitslip_int <= '0';
                                     Wait1Cycle <= '0';
                                     Wait2Cycle <= '0';
                                     Wait3CYcle <= '0';
                                     BitslipDone <= '0';
                end case;
            end if;
            -- Verification of the state
            if (BitslipDone = '0') then
                S_State <= ExecuteBitslip;
            else 
                S_State <= CheckIfBitslip;
            end if;
            
        when CheckIfBitslip =>
        -- Register is assigned on each rising_edge of the frame clock
            if rising_edge(FCLK_INT_R) then
                Register_Out(13) <= Q1;
                Register_Out(12) <= Q2;
                Register_Out(11) <= Q3;
                Register_Out(10) <= Q4; 
                Register_Out(9) <= Q5;
                Register_Out(8) <= Q6;
                Register_Out(7) <= Q7; 
                Register_Out(6) <= Q8;
                Register_Out(5) <= Q9;
                Register_Out(4) <= Q10;
                Register_Out(3) <= Q11;
                Register_Out(2) <= Q12;
                Register_Out(1) <= Q13;
                Register_Out(0) <= Q14; 
                -- Let's check if another bitslip is necessary (bits are stil misalligned)        
                if (Register_Out = "00000000000001") then
                    -- No more bitslips needed
                    NeedBitslip <= '0';
                    DataAlligned <= '1';
                    --FinalReg <= Register_Out;
                    --FinalLED <= Q14 & Q7 & Q6 & Q5 & Q4 & Q3 & Q2 & Q1;
                    showRegInLED <= Q14 & Q7 & Q6 & Q5 & Q4 & Q3 & Q2 & Q1;--FinalLED;
                else 
                    -- Another bitslip operation is needed
                    NeedBitslip <= '1';
                    DataAlligned <= '0';
                    --FinalReg <= "00000000000000";
                    --FinalLED <= "00000000";
                    showRegInLED <= Q14 & Q7 & Q6 & Q5 & Q4 & Q3 & Q2 & Q1;--FinalLED;
                end if;
            end if;                 
            -- Verification of the state
            if (NeedBitslip = '0') then
                S_State <= NoOperation;
            else 
                S_State <= ExecuteBitslip;
            end if;    
    end case;
end process Comb;
end Behavioral;
