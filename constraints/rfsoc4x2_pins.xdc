# vp/vn need analog setting
set_property IOSTANDARD ANALOG [get_ports VP]
set_property IOSTANDARD ANALOG [get_ports VN]
# don't think clocks need iostandards? maybe?
set_property PACKAGE_PIN AF5 [get_ports ADC0_CLK_P]
set_property PACKAGE_PIN AF4 [get_ports ADC0_CLK_N]

set_property PACKAGE_PIN AB5 [get_ports ADC4_CLK_P]
set_property PACKAGE_PIN AB4 [get_ports ADC4_CLK_N]

set_property PACKAGE_PIN R5 [get_ports DAC0_CLK_P]
set_property PACKAGE_PIN R4 [get_ports DAC0_CLK_N]

set_property PACKAGE_PIN U2 [get_ports DAC0_VOUT_P]
set_property PACKAGE_PIN U1 [get_ports DAC0_VOUT_N]

# maybe these don't even need anything?
set_property -dict { PACKAGE_PIN AP2 } [get_ports ADC0_VIN_P]
set_property -dict { PACKAGE_PIN AP1 } [get_ports ADC0_VIN_N]
set_property -dict { PACKAGE_PIN AM2 } [get_ports ADC1_VIN_P]
set_property -dict { PACKAGE_PIN AM1 } [get_ports ADC1_VIN_N]

set_property -dict { PACKAGE_PIN AF2 } [get_ports ADC4_VIN_P]
set_property -dict { PACKAGE_PIN AF1 } [get_ports ADC4_VIN_N]
set_property -dict { PACKAGE_PIN AD2 } [get_ports ADC5_VIN_P]
set_property -dict { PACKAGE_PIN AD1 } [get_ports ADC5_VIN_N]

set_property -dict { IOSTANDARD LVDS DIFF_TERM TRUE PACKAGE_PIN AP18 } [get_ports SYSREF_FPGA_P]
set_property -dict { IOSTANDARD LVDS DIFF_TERM TRUE PACKAGE_PIN AR18 } [get_ports SYSREF_FPGA_N]
set_property -dict { IOSTANDARD LVDS DIFF_TERM TRUE PACKAGE_PIN AN11 } [get_ports FPGA_REFCLK_IN_P]
set_property -dict { IOSTANDARD LVDS DIFF_TERM TRUE PACKAGE_PIN AP11 } [get_ports FPGA_REFCLK_IN_N]