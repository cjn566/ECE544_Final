# 
# Synthesis run script generated by Vivado
# 

set_param gui.test TreeTableDev
debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

create_project -in_memory -part xc7a100tcsg324-1
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.cache/wt [current_project]
set_property parent.project_path C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
add_files c:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/image_stuff/ball.coe
add_files c:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/image_stuff/labyrinth02.coe
add_files c:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/image_stuff/success00.coe
add_files -quiet C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.runs/icon_rom_synth_1/icon_rom.dcp
set_property used_in_implementation false [get_files C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.runs/icon_rom_synth_1/icon_rom.dcp]
add_files -quiet C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.runs/clk_wizard_synth_1/clk_wizard.dcp
set_property used_in_implementation false [get_files C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.runs/clk_wizard_synth_1/clk_wizard.dcp]
add_files -quiet C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.runs/maze_memory_synth_1/maze_memory.dcp
set_property used_in_implementation false [get_files C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.runs/maze_memory_synth_1/maze_memory.dcp]
add_files -quiet C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.runs/success_synth_1/success.dcp
set_property used_in_implementation false [get_files C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.runs/success_synth_1/success.dcp]
read_verilog -library xil_defaultlib {
  C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/sevensegment.v
  C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/map.v
  C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/dtg.v
  C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/nexys4fpga_with_vga_no_accel.v
  C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/ball_vid_buttons.v
  C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/debounce.v
  C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/icon.v
  C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/vga_subsystem.v
  C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/colorizer.v
  C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/accel_threshold_ticker.v
  C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/score.v
  C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/draw_success.v
}
read_vhdl -library xil_defaultlib {
  C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/SPI_If.vhd
  C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/AccelerometerCtl.vhd
  C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/AccelArithmetics.vhd
  C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/ADXL362Ctrl.vhd
}
read_xdc C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/nexys4fpga_withvideo.xdc
set_property used_in_implementation false [get_files C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/nexys4fpga_withvideo.xdc]

catch { write_hwdef -file Nexys4fpga.hwdef }
synth_design -top Nexys4fpga -part xc7a100tcsg324-1
write_checkpoint -noxdef Nexys4fpga.dcp
catch { report_utilization -file Nexys4fpga_utilization_synth.rpt -pb Nexys4fpga_utilization_synth.pb }
