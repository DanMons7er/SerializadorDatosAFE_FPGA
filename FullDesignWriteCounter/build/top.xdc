################################################################################
# IO constraints
################################################################################
# afe:0.fclkp
set_property LOC C14 [get_ports {afe_fclkp}]
set_property IOSTANDARD LVDS_25 [get_ports {afe_fclkp}]

# afe:0.fclkn
set_property LOC C15 [get_ports {afe_fclkn}]
set_property IOSTANDARD LVDS_25 [get_ports {afe_fclkn}]

# afe:0.dclkp
set_property LOC C18 [get_ports {afe_dclkp}]
set_property IOSTANDARD LVDS_25 [get_ports {afe_dclkp}]

# afe:0.dclkn
set_property LOC C19 [get_ports {afe_dclkn}]
set_property IOSTANDARD LVDS_25 [get_ports {afe_dclkn}]

# afe:0.datap
set_property LOC E19 [get_ports {afe_datap[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {afe_datap[0]}]

# afe:0.datap
set_property LOC E21 [get_ports {afe_datap[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {afe_datap[1]}]

# afe:0.datap
set_property LOC B21 [get_ports {afe_datap[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {afe_datap[2]}]

# afe:0.datap
set_property LOC B15 [get_ports {afe_datap[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {afe_datap[3]}]

# afe:0.datap
set_property LOC F16 [get_ports {afe_datap[4]}]
set_property IOSTANDARD LVDS_25 [get_ports {afe_datap[4]}]

# afe:0.datap
set_property LOC F18 [get_ports {afe_datap[5]}]
set_property IOSTANDARD LVDS_25 [get_ports {afe_datap[5]}]

# afe:0.datap
set_property LOC B20 [get_ports {afe_datap[6]}]
set_property IOSTANDARD LVDS_25 [get_ports {afe_datap[6]}]

# afe:0.datap
set_property LOC C13 [get_ports {afe_datap[7]}]
set_property IOSTANDARD LVDS_25 [get_ports {afe_datap[7]}]

# afe:0.datan
set_property LOC D19 [get_ports {afe_datan[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {afe_datan[0]}]

# afe:0.datan
set_property LOC D21 [get_ports {afe_datan[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {afe_datan[1]}]

# afe:0.datan
set_property LOC A21 [get_ports {afe_datan[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {afe_datan[2]}]

# afe:0.datan
set_property LOC B16 [get_ports {afe_datan[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {afe_datan[3]}]

# afe:0.datan
set_property LOC E17 [get_ports {afe_datan[4]}]
set_property IOSTANDARD LVDS_25 [get_ports {afe_datan[4]}]

# afe:0.datan
set_property LOC E18 [get_ports {afe_datan[5]}]
set_property IOSTANDARD LVDS_25 [get_ports {afe_datan[5]}]

# afe:0.datan
set_property LOC A20 [get_ports {afe_datan[6]}]
set_property IOSTANDARD LVDS_25 [get_ports {afe_datan[6]}]

# afe:0.datan
set_property LOC B13 [get_ports {afe_datan[7]}]
set_property IOSTANDARD LVDS_25 [get_ports {afe_datan[7]}]

# user_btn:0
set_property LOC B22 [get_ports {user_btn0}]
set_property IOSTANDARD LVCMOS25 [get_ports {user_btn0}]

# user_btn:1
set_property LOC D22 [get_ports {user_btn1}]
set_property IOSTANDARD LVCMOS25 [get_ports {user_btn1}]

# user_sw:7
set_property LOC M17 [get_ports {user_sw7}]
set_property IOSTANDARD LVCMOS25 [get_ports {user_sw7}]

# user_sw:6
set_property LOC K13 [get_ports {user_sw6}]
set_property IOSTANDARD LVCMOS25 [get_ports {user_sw6}]

# user_sw:5
set_property LOC J16 [get_ports {user_sw5}]
set_property IOSTANDARD LVCMOS25 [get_ports {user_sw5}]

# user_sw:4
set_property LOC H17 [get_ports {user_sw4}]
set_property IOSTANDARD LVCMOS25 [get_ports {user_sw4}]

# user_sw:3
set_property LOC G22 [get_ports {user_sw3}]
set_property IOSTANDARD LVCMOS25 [get_ports {user_sw3}]

# user_sw:2
set_property LOC G21 [get_ports {user_sw2}]
set_property IOSTANDARD LVCMOS25 [get_ports {user_sw2}]

# user_sw:1
set_property LOC F21 [get_ports {user_sw1}]
set_property IOSTANDARD LVCMOS25 [get_ports {user_sw1}]

# user_led:0
set_property LOC T14 [get_ports {user_led0}]
set_property IOSTANDARD LVCMOS25 [get_ports {user_led0}]

# user_led:1
set_property LOC T15 [get_ports {user_led1}]
set_property IOSTANDARD LVCMOS25 [get_ports {user_led1}]

# user_led:2
set_property LOC T16 [get_ports {user_led2}]
set_property IOSTANDARD LVCMOS25 [get_ports {user_led2}]

# user_led:3
set_property LOC U16 [get_ports {user_led3}]
set_property IOSTANDARD LVCMOS25 [get_ports {user_led3}]

# user_led:4
set_property LOC V15 [get_ports {user_led4}]
set_property IOSTANDARD LVCMOS25 [get_ports {user_led4}]

# user_led:5
set_property LOC W16 [get_ports {user_led5}]
set_property IOSTANDARD LVCMOS25 [get_ports {user_led5}]

# user_led:6
set_property LOC W15 [get_ports {user_led6}]
set_property IOSTANDARD LVCMOS25 [get_ports {user_led6}]

# user_led:7
set_property LOC Y13 [get_ports {user_led7}]
set_property IOSTANDARD LVCMOS25 [get_ports {user_led7}]

# clk100:0
set_property LOC R4 [get_ports {clk100}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk100}]

# serial:0.tx
set_property LOC AA19 [get_ports {serial_tx}]
set_property IOSTANDARD LVCMOS33 [get_ports {serial_tx}]

# serial:0.rx
set_property LOC V18 [get_ports {serial_rx}]
set_property IOSTANDARD LVCMOS33 [get_ports {serial_rx}]

################################################################################
# Design constraints
################################################################################

set_property INTERNAL_VREF 0.750 [get_iobanks 35]

set_property INTERNAL_VREF 0.9 [get_iobanks 16]

set_property CFGBVS GND [current_design]

set_property CONFIG_VOLTAGE 1.8 [current_design]

################################################################################
# Clock constraints
################################################################################


create_clock -name clk100 -period 10.0 [get_nets clk100]

################################################################################
# False path constraints
################################################################################


set_false_path -quiet -through [get_nets -hierarchical -filter {mr_ff == TRUE}]

set_false_path -quiet -to [get_pins -filter {REF_PIN_NAME == PRE} -of_objects [get_cells -hierarchical -filter {ars_ff1 == TRUE || ars_ff2 == TRUE}]]

set_max_delay 2 -quiet -from [get_pins -filter {REF_PIN_NAME == C} -of_objects [get_cells -hierarchical -filter {ars_ff1 == TRUE}]] -to [get_pins -filter {REF_PIN_NAME == D} -of_objects [get_cells -hierarchical -filter {ars_ff2 == TRUE}]]