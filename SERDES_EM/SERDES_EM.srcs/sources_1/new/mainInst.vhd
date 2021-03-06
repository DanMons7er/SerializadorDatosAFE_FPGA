----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.04.2021 10:11:09
-- Design Name: 
-- Module Name: mainInstantiation - Behavioral
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

entity mainInstantiation is
    Port ( inputClockP: in std_logic;   -- Diff_p buffer input for for the bit clock
           inputClockN: in std_logic;   -- Diff_n buffer input for for the bit clock       
           frameInputP: in std_logic;   -- Input P Frame from AFE
           frameInputN: in std_logic;   -- Input N Frame from AFE
           Data_N: in std_logic;        -- Data Input N
           Data_P: in std_logic;        -- Data Input P
           RST_BTNC: in std_logic;
           showRegInLED: out std_logic_vector (0 to 7));    --Led of Nexys
           
end mainInstantiation;

architecture Behavioral of mainInstantiation is

--COMPONENTS
component diffBuff is 
    port( buffInP: in std_logic;
          buffInN: in std_logic;
          buffOut: out std_logic);
end component;

component CLK_RETRIEVER is
    Port( InPll: in std_logic;
          p0: out std_logic;
          p1: out std_logic;
          p2: out std_logic;
          p3: out std_logic);
end component;

--COMPONENT MUX4
component MUX4 is
    Port ( In1 : in STD_LOGIC;
           In2 : in STD_LOGIC;
           In3 : in STD_LOGIC;
           In4 : in STD_LOGIC;
           S : in STD_LOGIC_VECTOR(1 downto 0);
           O : out STD_LOGIC);
end component;

component S2P is
  Port ( ResetISERDES: in STD_LOGIC;
         InputFrameData: in STD_LOGIC;
         DigitalFrameCLk: in STD_LOGIC;
         BitslipManager: in STD_LOGIC;
         Q0: out STD_LOGIC;   
         Q1: out STD_LOGIC;
         Q2: out STD_LOGIC;   
         Q3: out STD_LOGIC;
         Q4: out STD_LOGIC;   
         Q5: out STD_LOGIC;
         Q6: out STD_LOGIC;   
         Q7: out STD_LOGIC;
         Q8: out STD_LOGIC;   
         Q9: out STD_LOGIC;
         Q10: out STD_LOGIC;   
         Q11: out STD_LOGIC;
         Q12: out STD_LOGIC;   
         Q13: out STD_LOGIC;
         BUFRODigitalFrameClkDivv: out STD_LOGIC
        );
end component;

component FSM_Frame is
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
end component;

component FSM_Bit is 
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
end component;


--SIGNAls
--Diffential Buff Signals
signal dfBfClkOut: std_logic;
signal dfBfFrameOut: std_logic;
signal dfBfDataOut: std_logic;
signal data: std_logic;

--ClK Retriever Signals
signal p0: std_logic;
signal p1: std_logic;
signal p2: std_logic;
signal p3: std_logic;

--Mux Signals
signal HypClk: std_logic;
signal MuxControl: std_logic_vector (1 downto 0);

--SERDES Signals
signal Q0: std_logic;
signal Q1: std_logic;
signal Q2: std_logic;
signal Q3: std_logic;
signal Q4: std_logic;
signal Q5: std_logic;
signal Q6: std_logic;
signal Q7: std_logic;
signal Q8: std_logic;
signal Q9: std_logic;
signal Q10: std_logic;
signal Q11: std_logic;
signal Q12: std_logic;
signal Q13: std_logic;
signal ClkEnable: std_logic;
signal Register_out: std_logic_vector (13 downto 0);
signal CLK_Divider: std_logic;

-- FSM_Bit Machine signals
signal BitReady: std_logic;
-- FSM_Frame Machine signals
signal BitslipControl: std_logic;

begin
    --Diffential Buff Instatiation For  Clock 
    DfBfCLK_inst: diffBuff PORT MAP (inputClockP,
                                     inputClockN,
                                     dfBfClkOut);
    
    --Diffential Buff Instatiation For Frame
    DfBfFrame_inst: diffBuff PORT MAP (frameInputP,
                                       frameInputN,
                                       dfBfFrameOut);
    
    --Diffential Buff Instatiation For Data
    DfBfData_inst: diffBuff PORT MAP (Data_P,
                                      Data_N,
                                      dfBfDataOut);                                   
    
    
--    IBUF_inst : IBUF
--    generic map (
--    IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
--    IOSTANDARD => "DEFAULT")
--    port map (
--    O => data, -- Buffer output
--    I => dfBfDataOut -- Buffer input (connect directly to top-level port)
--    );
    
    
    --Clk Retriever Instantiation
    Retriever_inst: CLK_RETRIEVER PORT MAP (dfBfClkOut,
                                            p0,
                                            p1,
                                            p2,
                                            p3);
    
    --Mux Instatiation
    Mux_inst: MUX4 PORT MAP (p0,
                             p1,
                             p2,
                             p3,
                             MuxControl,
                             HypClk); 
                        
    SERDES_inst: S2P PORT MAP (RST_BTNC,
                               dfBfDataOut,
                               HypClk,
                               BitslipControl,
                               Q0,
                               Q1,
                               Q2,
                               Q3,
                               Q4,
                               Q5,
                               Q6,
                               Q7,
                               Q8,
                               Q9,
                               Q10,
                               Q11,
                               Q12,
                               Q13,
                               CLK_Divider); 

    -- Finite State Machine for Bit CLock Allignment Instantiation
    FiniteStateMachine_BitAllign: FSM_Bit PORT MAP ( HypClk,
                                                     Q0,
                                                     Q1,
                                                     Q2,
                                                     Q3,
                                                     Q4,
                                                     Q5,
                                                     Q6,
                                                     Q7,
                                                     Q8,
                                                     Q9,
                                                     Q10,
                                                     Q11,
                                                     Q12,
                                                     Q13,
                                                     dfBfFrameOut,
                                                     RST_BTNC,
                                                     MuxControl,
                                                     BitReady);

    -- Finite State Machine for Frame Clock Allignment Instantiation
    FiniteStateMachine_FrameAllign: FSM_Frame PORT MAP ( Q0,
                                                         Q1,
                                                         Q2,
                                                         Q3,
                                                         Q4,
                                                         Q5,
                                                         Q6,
                                                         Q7,
                                                         Q8,
                                                         Q9,
                                                         Q10,
                                                         Q11,
                                                         Q12,
                                                         Q13, 
                                                         dfBfFrameOut,
                                                         RST_BTNC,
                                                         CLK_Divider,
                                                         BitReady,
                                                         showRegInLED,
                                                         BitslipControl);   
                                                                   
end Behavioral;