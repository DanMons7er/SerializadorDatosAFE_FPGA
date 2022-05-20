----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.04.2021 10:47:58
-- Design Name: 
-- Module Name: PLL - Behavioral
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

entity PLL is
    Port ( clkIn: in STD_LOGIC; --Clock in
           feedbackIn: in STD_LOGIC; 
           p0: out STD_LOGIC; --Phase 0
           p1: out STD_LOGIC; --Phase 1
           p2: out STD_LOGIC; --Phase 2
           p3: out STD_LOGIC; --Phase 3
           feedbackOut: out STD_LOGIC);
end PLL;

architecture Behavioral of PLL is

signal CLKOUT0: std_logic;
signal CLKOUT1: std_logic;
signal CLKOUT2: std_logic;
signal CLKOUT3: std_logic;
signal CLKOUT4: std_logic;
signal CLKOUT5: std_logic;
signal CLKFBOUT: std_logic;
signal LOCKED: std_logic;
signal PWRDWN: std_logic;
signal RST: std_logic;
signal CLKFBIN: std_logic;


begin

   PLLE2_BASE_inst : PLLE2_BASE
   generic map (
      BANDWIDTH => "OPTIMIZED",  -- OPTIMIZED, HIGH, LOW
      CLKFBOUT_MULT => 3,        -- Multiply value for all CLKOUT, (2-64)
      CLKFBOUT_PHASE => 0.0,     -- Phase offset in degrees of CLKFB, (-360.000-360.000).
      CLKIN1_PERIOD => 3.571,      -- Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
      -- CLKOUT0_DIVIDE - CLKOUT5_DIVIDE: Divide amount for each CLKOUT (1-128)
      CLKOUT0_DIVIDE => 3,
      CLKOUT1_DIVIDE => 3,
      CLKOUT2_DIVIDE => 3,
      CLKOUT3_DIVIDE => 3,
      CLKOUT4_DIVIDE => 3,
      CLKOUT5_DIVIDE => 3,
      -- CLKOUT0_DUTY_CYCLE - CLKOUT5_DUTY_CYCLE: Duty cycle for each CLKOUT (0.001-0.999).
      CLKOUT0_DUTY_CYCLE => 0.5,
      CLKOUT1_DUTY_CYCLE => 0.5,
      CLKOUT2_DUTY_CYCLE => 0.5,
      CLKOUT3_DUTY_CYCLE => 0.5,
      CLKOUT4_DUTY_CYCLE => 0.5,
      CLKOUT5_DUTY_CYCLE => 0.5,
      -- CLKOUT0_PHASE - CLKOUT5_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
      CLKOUT0_PHASE => 0.0,
      CLKOUT1_PHASE => 90.0,
      CLKOUT2_PHASE => 180.0,
      CLKOUT3_PHASE => 270.0,
      CLKOUT4_PHASE => 0.0,
      CLKOUT5_PHASE => 0.0,
      DIVCLK_DIVIDE => 1,        -- Master division value, (1-56)
      REF_JITTER1 => 0.0,        -- Reference input jitter in UI, (0.000-0.999).
      STARTUP_WAIT => "FALSE"    -- Delay DONE until PLL Locks, ("TRUE"/"FALSE")
   )
   port map (
      -- Clock Outputs: 1-bit (each) output: User configurable clock outputs
      CLKOUT0 => CLKOUT0,   -- 1-bit output: CLKOUT0
      CLKOUT1 => CLKOUT1,   -- 1-bit output: CLKOUT1
      CLKOUT2 => CLKOUT2,   -- 1-bit output: CLKOUT2
      CLKOUT3 => CLKOUT3,   -- 1-bit output: CLKOUT3
      CLKOUT4 => CLKOUT4,   -- 1-bit output: CLKOUT4
      CLKOUT5 => CLKOUT5,   -- 1-bit output: CLKOUT5
      -- Feedback Clocks: 1-bit (each) output: Clock feedback ports
      CLKFBOUT => CLKFBOUT, -- 1-bit output: Feedback clock
      LOCKED => LOCKED,     -- 1-bit output: LOCK
      CLKIN1 => clkIn,     -- 1-bit input: Input clock
      -- Control Ports: 1-bit (each) input: PLL control ports
      PWRDWN => PWRDWN,     -- 1-bit input: Power-down
      RST => RST,           -- 1-bit input: Reset
      -- Feedback Clocks: 1-bit (each) input: Clock feedback ports
      CLKFBIN => feedbackIn    -- 1-bit input: Feedback clock
   );
 
    p0 <= CLKOUT0;
    p1 <= CLKOUT1;
    p2 <= CLKOUT2;
    p3 <= CLKOUT3;
    feedbackOut <= CLKFBOUT;
end Behavioral;