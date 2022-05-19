create_clock -period 10.000 -name refclk_c2c_clk [get_ports refclk_c2c_clk_p]
set_property PACKAGE_PIN AC37  [get_ports refclk_c2c_clk_n]
set_property PACKAGE_PIN AC36  [get_ports refclk_c2c_clk_p]

create_clock -period 3.333 -name clk_300_clk_p [get_ports clk_300_clk_p]
set_property PACKAGE_PIN K29 [get_ports clk_300_clk_p]
set_property PACKAGE_PIN J29 [get_ports clk_300_clk_n]


set_property IOSTANDARD LVDS [get_ports clk_300_clk_n]
set_property IOSTANDARD LVDS [get_ports clk_300_clk_p]

set_property PACKAGE_PIN BF30 [get_ports I2C_C2C_scl_io]
set_property PACKAGE_PIN BE30 [get_ports I2C_C2C_sda_io]
set_property IOSTANDARD LVCMOS18 [get_ports I2C_C2C_scl_io]
set_property IOSTANDARD LVCMOS18 [get_ports I2C_C2C_sda_io]


set_property LOC  GTYE4_CHANNEL_X0Y28 [get_cells -hierarchical -filter {NAME =~ U_axiInfra/*channel_inst[0].*CHANNEL_PRIM_INST}]
set_property LOC  GTYE4_CHANNEL_X0Y29 [get_cells -hierarchical -filter {NAME =~ U_axiInfra/*channel_inst[1].*CHANNEL_PRIM_INST}]


set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]


######


create_generated_clock -name axiClk      [get_pins U_axiInfra/*/inst/mmcme*_adv_inst/CLKOUT0]
create_generated_clock -name clk100osc   [get_pins U_axiInfra/*/inst/mmcme*_adv_inst/CLKOUT1]
create_generated_clock -name clk200osc   [get_pins U_axiInfra/*/inst/mmcme*_adv_inst/CLKOUT2]
create_generated_clock -name clk40osc    [get_pins U_axiInfra/*/inst/mmcme*_adv_inst/CLKOUT3]
create_generated_clock -name clk80osc    [get_pins U_axiInfra/*/inst/mmcme*_adv_inst/CLKOUT4]
create_generated_clock -name clk10osc    [get_pins U_axiInfra/*/inst/mmcme*_adv_inst/CLKOUT5]

set_clock_groups -quiet -asynchronous -group axiClk -group [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ U_axiInfra/*CHANNEL_PRIM_INST/RXOUTCLK}]]
set_clock_groups -quiet -asynchronous -group axiClk -group [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ U_axiInfra/*CHANNEL_PRIM_INST/TXOUTCLK}]]

set_clock_groups -quiet -asynchronous -group axiClk -group [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ U_axiInfra/*CHANNEL_PRIM_INST/TXOUTCLKPCS}]]
set_clock_groups -quiet -asynchronous -group axiClk -group [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ U_axiInfra/*CHANNEL_PRIM_INST/RXOUTCLKPCS}]]

set_clock_groups -quiet -asynchronous -group axiClk -group [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ U_axiInfra/*.bufg_gt_usrclk2_inst/O}]]
set_clock_groups -quiet -asynchronous -group [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ U_axiInfra/*CHANNEL_PRIM_INST/RXOUTCLK}]] -group [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ U_axiInfra/*.bufg_gt_usrclk2_inst/O}]]

