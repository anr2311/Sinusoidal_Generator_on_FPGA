@echo off
set xv_path=E:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xelab  -wto ec4bde5ec12946e98c1c4b40d082269c -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot tb_pwm_gen_behav xil_defaultlib.tb_pwm_gen xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
