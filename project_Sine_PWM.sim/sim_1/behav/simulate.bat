@echo off
set xv_path=E:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xsim tb_pwm_gen_behav -key {Behavioral:sim_1:Functional:tb_pwm_gen} -tclbatch tb_pwm_gen.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
