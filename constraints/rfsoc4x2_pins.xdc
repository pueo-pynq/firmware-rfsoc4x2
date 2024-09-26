# vp/vn need analog setting
set_property IOSTANDARD ANALOG [get_ports VP]
set_property IOSTANDARD ANALOG [get_ports VN]
# don't think clocks need iostandards? maybe?

# clks
set_property PACKAGE_PIN R5 [get_ports DAC0_CLK_P]
set_property PACKAGE_PIN R4 [get_ports DAC0_CLK_N]
set_property PACKAGE_PIN AF5 [get_ports ADC0_CLK_P]
set_property PACKAGE_PIN AF4 [get_ports ADC0_CLK_N]
set_property PACKAGE_PIN AB5 [get_ports ADC4_CLK_P]
set_property PACKAGE_PIN AB4 [get_ports ADC4_CLK_N]

# maybe these don't even need anything?
set_property -dict {PACKAGE_PIN AP2} [get_ports ADC0_VIN_P]
set_property -dict {PACKAGE_PIN AP1} [get_ports ADC0_VIN_N]
set_property -dict {PACKAGE_PIN AM2} [get_ports ADC1_VIN_P]
set_property -dict {PACKAGE_PIN AM1} [get_ports ADC1_VIN_N]

set_property -dict {PACKAGE_PIN AF2} [get_ports ADC4_VIN_P]
set_property -dict {PACKAGE_PIN AF1} [get_ports ADC4_VIN_N]
set_property -dict {PACKAGE_PIN AD2} [get_ports ADC5_VIN_P]
set_property -dict {PACKAGE_PIN AD1} [get_ports ADC5_VIN_N]

set_property IOSTANDARD LVDS [get_ports SYSREF_FPGA_P]
set_property DIFF_TERM_ADV TERM_100 [get_ports SYSREF_FPGA_P]
set_property IOSTANDARD LVDS [get_ports SYSREF_FPGA_N]
set_property DIFF_TERM_ADV TERM_100 [get_ports SYSREF_FPGA_N]
set_property PACKAGE_PIN AP18 [get_ports SYSREF_FPGA_P]
set_property PACKAGE_PIN AR18 [get_ports SYSREF_FPGA_N]
set_property IOSTANDARD LVDS [get_ports FPGA_REFCLK_IN_P]
set_property DIFF_TERM_ADV TERM_100 [get_ports FPGA_REFCLK_IN_P]
set_property IOSTANDARD LVDS [get_ports FPGA_REFCLK_IN_N]
set_property DIFF_TERM_ADV TERM_100 [get_ports FPGA_REFCLK_IN_N]
set_property PACKAGE_PIN AN11 [get_ports FPGA_REFCLK_IN_P]
set_property PACKAGE_PIN AP11 [get_ports FPGA_REFCLK_IN_N]

create_clock -period 2.667 -name aclkin [get_ports -filter { NAME =~ "FPGA_REFCLK_IN_P" && DIRECTION == "IN" }]
set_max_delay -datapath_only -from [get_cells -hier -filter {NAME =~ *FlagToggle_clkA_reg*}] -to [get_cells -hier -filter {NAME =~ *SyncA_clkB_reg*}] 10.000
set_max_delay -datapath_only -from [get_cells -hier -filter {NAME =~ *SyncA_clkB_reg*}] -to [get_cells -hier -filter {NAME =~ *SyncB_clkA_reg*}] 10.000
set_max_delay -datapath_only -from [get_cells -hier -filter {CUSTOM_CC_SRC == ACLK}] -to [get_cells -hier -filter {CUSTOM_CC_DST == PSCLK}] 2.667
set_max_delay -datapath_only -from [get_cells -hier -filter {CUSTOM_CC_SRC == ACLKDIV2}] -to [get_cells -hier -filter {CUSTOM_CC_DST == PSCLK}] 5.334
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets ps_clk]
