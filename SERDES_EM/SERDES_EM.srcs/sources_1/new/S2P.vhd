----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2021 22:26:04
-- Design Name: 
-- Module Name: try - Behavioral
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

entity S2P is
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
end S2P;

architecture Behavioral of S2P is
signal ShiftIO1: STD_LOGIC;
signal ShiftIO2: STD_LOGIC;
-- Signals not used as input or outputs
signal AuxQ1Slave: STD_LOGIC;
signal AuxQ2Slave: STD_LOGIC;
-- Combinatorial outputs of the ISERDESES that are not used
signal OMaster: STD_LOGIC;
signal OSlave: STD_LOGIC;
-- Shift IO pins signals for both Master and Slave
signal ShiftI1Master: STD_LOGIC;
signal ShiftI2Master: STD_LOGIC;
signal ShiftO1Slave: STD_LOGIC;
signal ShiftO2Slave: STD_LOGIC;
-- Data input for the Slave
signal DSlave: STD_LOGIC;
-- Inverted Clock
signal OInvDigitalFrameCLk: STD_LOGIC;
signal IInvDigitalFrameClk: STD_LOGIC;
-- ClkDIVP pins
signal ClkDIVPMaster: STD_LOGIC;
signal ClkDIVPSlave: STD_LOGIC;
-- Bitslip opperation pins
--signal BitslipMaster: STD_LOGIC;
--signal BitslipSlave: STD_LOGIC;
-- Oversampling Mode signals, not used because of Networking interface mode enabled
signal OCLKMaster: STD_LOGIC;
signal OCLKSlave: STD_LOGIC;
signal OCLKBMaster: STD_LOGIC;
signal OCLKBSlave: STD_LOGIC;
-- Delay Data input pins 
signal DDLYMaster: STD_LOGIC;
signal DDLYSlave: STD_LOGIC;
-- Dynamic Clock Inversions pins not supported in Networking mode
signal DYNCLKDIVSEL_Master: STD_LOGIC;
signal DYNCLKSEL_Master: STD_LOGIC;
signal DYNCLKDIVSEL_Slave: STD_LOGIC;
signal DYNCLKSEL_Slave: STD_LOGIC;
-- Iserdese Feedback from Oserdese pins when OFB_Used=TRUE, not in this case
signal OFBMaster: STD_LOGIC;
signal OFBSlave: STD_LOGIC;
-- Clock Enable second pin that is unused
signal CE2Master: STD_LOGIC;
signal CE2Slave: STD_LOGIC;
-- Clock signals used for the input clock buffers to both Iserdes
signal BUFIODigitalFrameClk: STD_LOGIC;
signal BUFRODigitalFrameClkDiv: STD_LOGIC;
-- Buffer for Clock control definitions
--signal CE_BUFR_DigClk_Div: STD_LOGIC; 
-- CLR_BUFR_DigClk_Div: STD_LOGIC;
signal data: std_logic;

begin

--    -- Buffer instantiated for Clk pin management
--    BUFIO_Clk_inst : BUFIO
--    port map (
--      O => BUFIODigitalFrameClk, -- 1-bit output: Clock output (connect to I/O clock loads).
--      I => DigitalFrameClk -- 1-bit input: Clock input (connect to an IBUF or BUFMR).
--    );
--    -- End of BUFIO_inst instantiation
       
    -- Buffer instantiated for ClkDIV pin management
    
--    IBUF_inst : IBUF
--    generic map (
--    IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
--    IOSTANDARD => "DEFAULT")
--    port map (
--    O => data, -- Buffer output
--    I => InputFrameData -- Buffer input (connect directly to top-level port)
--    );  
    
    
    BUFR_ClkDiv_inst : BUFR
    generic map (
      BUFR_DIVIDE => "BYPASS",   -- Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8" 
      SIM_DEVICE => "7SERIES"  -- Must be set to "7SERIES" 
    )
    port map (
      O => BUFRODigitalFrameClkDiv,     -- 1-bit output: Clock output port
      CE => '1',--ClkEnable,   -- 1-bit input: Active high, clock enable (Divided modes only)
      CLR =>'0', --CLR_BUFR_DigClk_Div, -- 1-bit input: Active high, asynchronous clear (Divided modes only)
      I => DigitalFrameClk      -- 1-bit input: Clock buffer input driven by an IBUF, MMCM or local interconnect
    );    
    -- End of BUFR_inst instantiation
    
    -- Let's invert the clock input
    IInvDigitalFrameClk <= not(DigitalFrameClk);
    --IInvDigitalFrameClk <= not(BUFIODigitalFrameClk);
    
    
    -- Clock Div output used by the Frame Alligner
    BUFRODigitalFrameClkDivv <= BUFRODigitalFrameClkDiv;
    
    -- Buffer used to manage the Clock inverter as an input in the system
--    BUFIO_ClkInv_inst : BUFIO
--    port map (
--      O => OInvDigitalFrameClk, -- 1-bit output: Clock output (connect to I/O clock loads).
--      I => IInvDigitalFrameClk -- 1-bit input: Clock input (connect to an IBUF or BUFMR).
--    );    
    -- End of BUFIO_inst instantiation
    
    -- Master ISERDES
    ISERDESE2_Master_inst : ISERDESE2
    generic map (
      DATA_RATE => "DDR",           -- DDR, SDR
      DATA_WIDTH => 14,              -- Parallel data width (2-8,10,14)
      DYN_CLKDIV_INV_EN => "FALSE", -- Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
      DYN_CLK_INV_EN => "FALSE",    -- Enable DYNCLKINVSEL inversion (FALSE, TRUE)
      -- INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
      INIT_Q1 => '0',
      INIT_Q2 => '0',
      INIT_Q3 => '0',
      INIT_Q4 => '0',
      INTERFACE_TYPE => "NETWORKING",   -- MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
      IOBDELAY => "NONE",           -- NONE, BOTH, IBUF, IFD
      NUM_CE => 1,                  -- Number of clock enables (1,2)
      OFB_USED => "FALSE",          -- Select OFB path (FALSE, TRUE)
      SERDES_MODE => "MASTER",      -- MASTER, SLAVE
      -- SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
      SRVAL_Q1 => '0',
      SRVAL_Q2 => '0',
      SRVAL_Q3 => '0',
      SRVAL_Q4 => '0'
    )
    port map (
      O => open,                       -- 1-bit output: Combinatorial output
      -- Q1 - Q8: 1-bit (each) output: Registered data outputs
      Q1 => Q13, -- Bit 13 or MSB
      Q2 => Q12,
      Q3 => Q11,
      Q4 => Q10,
      Q5 => Q9,
      Q6 => Q8,
      Q7 => Q7,
      Q8 => Q6,
      -- SHIFTOUT1, SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
      SHIFTOUT1 => ShiftIO1,
      SHIFTOUT2 => ShiftIO2,
      BITSLIP => BitslipManager,           -- 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
                                    -- CLKDIV when asserted (active High). Subsequently, the data seen on the
                                    -- Q1 to Q8 output ports will shift, as in a barrel-shifter operation, one
                                    -- position every time Bitslip is invoked (DDR operation is different from
                                    -- SDR).
    
      -- CE1, CE2: 1-bit (each) input: Data register clock enable inputs
      CE1 => '1',--ClkEnable,
      CE2 => '0',--CE2Master,
      CLKDIVP => '0',--ClkDIVPMaster,           -- 1-bit input: TBD
      -- Clocks: 1-bit (each) input: ISERDESE2 clock input ports
      CLK => DigitalFrameClk,                   -- 1-bit input: High-speed clock
      CLKB => IInvDigitalFrameClk,                 -- 1-bit input: High-speed secondary clock
      CLKDIV => BUFRODigitalFrameClkDiv,             -- 1-bit input: Divided clock
      OCLK => '0',--OCLKMaster,                 -- 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
      -- Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
      DYNCLKDIVSEL => '0',--DYNCLKDIVSEL_Master, -- 1-bit input: Dynamic CLKDIV inversion
      DYNCLKSEL => '0',--DYNCLKSEL_Master,       -- 1-bit input: Dynamic CLK/CLKB inversion
      -- Input Data: 1-bit (each) input: ISERDESE2 data input ports
      D => InputFrameData , -- data,                       -- 1-bit input: Data input
      DDLY => '0',--DDLYMaster,                 -- 1-bit input: Serial data from IDELAYE2
      OFB => '0',--OFBMaster,                   -- 1-bit input: Data feedback from OSERDESE2
      OCLKB => '0',--OCLKBMaster,               -- 1-bit input: High speed negative edge output clock
      RST => ResetISERDES,                   -- 1-bit input: Active high asynchronous reset
      -- SHIFTIN1, SHIFTIN2: 1-bit (each) input: Data width expansion input ports
      SHIFTIN1 => '0',--ShiftI1Master,
      SHIFTIN2 => '0'--ShiftI2Master
    );
    -- End of ISERDESE2_Master_inst instantiation
    
    -- Slave ISERDES
    ISERDESE2_Slave_inst : ISERDESE2
    generic map (
      DATA_RATE => "DDR",           -- DDR, SDR
      DATA_WIDTH => 14,              -- Parallel data width (2-8,10,14)
      DYN_CLKDIV_INV_EN => "FALSE", -- Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
      DYN_CLK_INV_EN => "FALSE",    -- Enable DYNCLKINVSEL inversion (FALSE, TRUE)
      -- INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
      INIT_Q1 => '0',
      INIT_Q2 => '0',
      INIT_Q3 => '0',
      INIT_Q4 => '0',
      INTERFACE_TYPE => "NETWORKING",   -- MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
      IOBDELAY => "NONE",           -- NONE, BOTH, IBUF, IFD
      NUM_CE => 1,                  -- Number of clock enables (1,2)
      OFB_USED => "FALSE",          -- Select OFB path (FALSE, TRUE)
      SERDES_MODE => "SLAVE",      -- MASTER, SLAVE
      -- SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
      SRVAL_Q1 => '0',
      SRVAL_Q2 => '0',
      SRVAL_Q3 => '0',
      SRVAL_Q4 => '0'
    )
    port map (
      O => open, --OSlave,                       -- 1-bit output: Combinatorial output
      -- Q1 - Q8: 1-bit (each) output: Registered data outputs
      Q1 => open,--AuxQ1Slave, -- This output is not used in Width Expansion
      Q2 => open, --AuxQ2Slave, -- This output is not used in Width Expansion
      Q3 => Q5,
      Q4 => Q4,
      Q5 => Q3,
      Q6 => Q2,
      Q7 => Q1,
      Q8 => Q0, -- Bit 0 or LSB 
      -- SHIFTOUT1, SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
      SHIFTOUT1 => open,--ShiftO1Slave,
      SHIFTOUT2 => open,--ShiftO2Slave,
      BITSLIP => BitslipManager,           -- 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
                                    -- CLKDIV when asserted (active High). Subsequently, the data seen on the
                                    -- Q1 to Q8 output ports will shift, as in a barrel-shifter operation, one
                                    -- position every time Bitslip is invoked (DDR operation is different from
                                    -- SDR).
    
      -- CE1, CE2: 1-bit (each) input: Data register clock enable inputs
      CE1 => '1',--ClkEnable,
      CE2 => '0',--CE2Slave,
      CLKDIVP => '0',--ClkDIVPSlave,           -- 1-bit input: TBD
      -- Clocks: 1-bit (each) input: ISERDESE2 clock input ports
      CLK => DigitalFrameClk,                   -- 1-bit input: High-speed clock
      CLKB => IInvDigitalFrameClk,                 -- 1-bit input: High-speed secondary clock
      CLKDIV => BUFRODigitalFrameClkDiv,             -- 1-bit input: Divided clock
      OCLK => '0',--OCLKSlave,                 -- 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
      -- Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
      DYNCLKDIVSEL => '0',--DYNCLKDIVSEL_Slave, -- 1-bit input: Dynamic CLKDIV inversion
      DYNCLKSEL => '0',--DYNCLKSEL_Slave,       -- 1-bit input: Dynamic CLK/CLKB inversion
      -- Input Data: 1-bit (each) input: ISERDESE2 data input ports
      D => '0',--open,--DSlave,                       -- 1-bit input: Data input
      DDLY => '0',--DDLYSlave,                 -- 1-bit input: Serial data from IDELAYE2
      OFB => '0',--OFBSlave,                   -- 1-bit input: Data feedback from OSERDESE2
      OCLKB => '0',--OCLKBSlave,               -- 1-bit input: High speed negative edge output clock
      RST => ResetISERDES,                   -- 1-bit input: Active high asynchronous reset
      -- SHIFTIN1, SHIFTIN2: 1-bit (each) input: Data width expansion input ports
      SHIFTIN1 => ShiftIO1,
      SHIFTIN2 => ShiftIO2
    );
    -- End of ISERDESE2_Slave_inst instantiation
end Behavioral;