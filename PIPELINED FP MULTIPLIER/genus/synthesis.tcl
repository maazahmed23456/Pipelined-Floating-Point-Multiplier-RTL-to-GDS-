set_db init_lib_search_path /home/ece_student/ec499_maaz/Pipelined_Multiplier/genus/library
set_db init_hdl_search_path /home/ece_student/ec499_maaz/Pipelined_Multiplier/genus/verilog

set_db library fast.lib
read_libs fast.lib

read_hdl Pipelined_Multiplier.v

elaborate 

create_clock -period 10 [get_ports clk]

syn_generic
syn_map
syn_opt


report_timing > reports/report_timing.rpt

report_power > reports/report_power.rpt

report_area > reports/report_area.rpt

write_hdl > outputs/syn.v

gui_show


