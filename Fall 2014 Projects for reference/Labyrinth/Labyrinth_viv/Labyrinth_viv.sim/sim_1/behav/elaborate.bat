@echo off
set xv_path=C:\\Xilinx\\Vivado\\2014.4\\bin
call %xv_path%/xelab  -wto 0f5ebbbc409741c3afd666dda8212110 -m64 --debug typical --relax -L blk_mem_gen_v8_2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot ball_collision_test_behav xil_defaultlib.ball_collision_test xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
