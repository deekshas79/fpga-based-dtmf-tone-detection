set_property PACKAGE_PIN K28  [get_ports clk_p]
set_property PACKAGE_PIN K29  [get_ports clk_n]
set_property PACKAGE_PIN AB7  [get_port rst]
set_property PACKAGE_PIN Y29  [get_port tone_sel[0]]
set_property PACKAGE_PIN W29  [get_port tone_sel[1]]
set_property PACKAGE_PIN AA28 [get_port tone_sel[2]]
set_property PACKAGE_PIN Y28  [get_port tone_sel[3]]
set_property PACKAGE_PIN AB12 [get_port start]

#--------Pin assignments for LED-----------------
# Low group
set_property PACKAGE_PIN AB8  [get_port low_grp[0]]
set_property PACKAGE_PIN AA8  [get_port low_grp[1]]
set_property PACKAGE_PIN AC9  [get_port low_grp[2]]
set_property PACKAGE_PIN AB9  [get_port low_grp[3]]

# High group
set_property PACKAGE_PIN AE26  [get_port high_grp[0]]
set_property PACKAGE_PIN G19   [get_port high_grp[1]]
set_property PACKAGE_PIN E18   [get_port high_grp[2]]
set_property PACKAGE_PIN F16   [get_port high_grp[3]]


set_property IOSTANDARD LVDS_25   [get_ports clk_p]
set_property IOSTANDARD LVDS_25   [get_ports clk_n]
set_property DIFF_TERM  TRUE      [get_ports clk_p]

set_property IOSTANDARD LVCMOS15  [get_port rst]
set_property IOSTANDARD LVCMOS25  [get_port tone_sel[0]]
set_property IOSTANDARD LVCMOS25  [get_port tone_sel[1]]
set_property IOSTANDARD LVCMOS25  [get_port tone_sel[2]]
set_property IOSTANDARD LVCMOS25  [get_port tone_sel[3]]
set_property IOSTANDARD LVCMOS15 [get_port start]

#--------Pin assignments for LED-----------------
# Low group
set_property IOSTANDARD LVCMOS15  [get_port low_grp[0]]
set_property IOSTANDARD LVCMOS15  [get_port low_grp[1]]
set_property IOSTANDARD LVCMOS15  [get_port low_grp[2]]
set_property IOSTANDARD LVCMOS15  [get_port low_grp[3]]

# High group
set_property IOSTANDARD LVCMOS25  [get_port high_grp[0]]
set_property IOSTANDARD LVCMOS25   [get_port high_grp[1]]
set_property IOSTANDARD LVCMOS25   [get_port high_grp[2]]
set_property IOSTANDARD LVCMOS25   [get_port high_grp[3]]
