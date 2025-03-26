# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.14-s082_1 on Sat Mar 15 17:30:55 IST 2025

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design Pipelined_Multiplier

create_clock -name "clk" -period 10.0 -waveform {0.0 5.0} [get_ports clk]
set_clock_gating_check -setup 0.0 
set_wire_load_mode "enclosed"
