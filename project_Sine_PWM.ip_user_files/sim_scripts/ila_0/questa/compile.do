vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm

vlog -work xil_defaultlib -64 -sv "+incdir+../../../../project_Sine_PWM.srcs/sources_1/ip/ila_0/hdl/verilog" "+incdir+../../../../project_Sine_PWM.srcs/sources_1/ip/ila_0/hdl/verilog" \
"D:/Xilinx/Vivado/2016.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/Xilinx/Vivado/2016.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../../project_Sine_PWM.srcs/sources_1/ip/ila_0/hdl/verilog" "+incdir+../../../../project_Sine_PWM.srcs/sources_1/ip/ila_0/hdl/verilog" \
"../../../../project_Sine_PWM.srcs/sources_1/ip/ila_0/sim/ila_0.v" \


vlog -work xil_defaultlib "glbl.v"

