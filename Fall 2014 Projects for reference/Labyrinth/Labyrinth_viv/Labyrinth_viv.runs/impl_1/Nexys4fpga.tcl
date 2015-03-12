proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param gui.test TreeTableDev
  debug::add_scope template.lib 1
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.cache/wt [current_project]
  set_property parent.project_path C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.xpr [current_project]
  set_property ip_repo_paths c:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.cache/ip [current_project]
  set_property ip_output_repo c:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.cache/ip [current_project]
  add_files -quiet C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.runs/synth_1/Nexys4fpga.dcp
  add_files -quiet C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.runs/icon_rom_synth_1/icon_rom.dcp
  set_property netlist_only true [get_files C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.runs/icon_rom_synth_1/icon_rom.dcp]
  add_files -quiet C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.runs/clk_wizard_synth_1/clk_wizard.dcp
  set_property netlist_only true [get_files C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.runs/clk_wizard_synth_1/clk_wizard.dcp]
  add_files -quiet C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.runs/maze_memory_synth_1/maze_memory.dcp
  set_property netlist_only true [get_files C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.runs/maze_memory_synth_1/maze_memory.dcp]
  add_files -quiet C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.runs/success_synth_1/success.dcp
  set_property netlist_only true [get_files C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.runs/success_synth_1/success.dcp]
  read_xdc -mode out_of_context -ref icon_rom -cells U0 c:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/icon_rom_1/icon_rom_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/icon_rom_1/icon_rom_ooc.xdc]
  read_xdc -mode out_of_context -ref clk_wizard -cells inst c:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/clk_wizard/clk_wizard_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/clk_wizard/clk_wizard_ooc.xdc]
  read_xdc -prop_thru_buffers -ref clk_wizard -cells inst c:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/clk_wizard/clk_wizard_board.xdc
  set_property processing_order EARLY [get_files c:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/clk_wizard/clk_wizard_board.xdc]
  read_xdc -ref clk_wizard -cells inst c:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/clk_wizard/clk_wizard.xdc
  set_property processing_order EARLY [get_files c:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/clk_wizard/clk_wizard.xdc]
  read_xdc -mode out_of_context -ref maze_memory c:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/maze_memory/maze_memory_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/maze_memory/maze_memory_ooc.xdc]
  read_xdc -mode out_of_context -ref success c:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/success/success_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/success/success_ooc.xdc]
  read_xdc C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth/accel/nexys4fpga_withvideo.xdc
  link_design -top Nexys4fpga -part xc7a100tcsg324-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force Nexys4fpga_opt.dcp
  catch {report_drc -file Nexys4fpga_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  place_design 
  write_checkpoint -force Nexys4fpga_placed.dcp
  catch { report_io -file Nexys4fpga_io_placed.rpt }
  catch { report_clock_utilization -file Nexys4fpga_clock_utilization_placed.rpt }
  catch { report_utilization -file Nexys4fpga_utilization_placed.rpt -pb Nexys4fpga_utilization_placed.pb }
  catch { report_control_sets -verbose -file Nexys4fpga_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force Nexys4fpga_routed.dcp
  catch { report_drc -file Nexys4fpga_drc_routed.rpt -pb Nexys4fpga_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file Nexys4fpga_timing_summary_routed.rpt -rpx Nexys4fpga_timing_summary_routed.rpx }
  catch { report_power -file Nexys4fpga_power_routed.rpt -pb Nexys4fpga_power_summary_routed.pb }
  catch { report_route_status -file Nexys4fpga_route_status.rpt -pb Nexys4fpga_route_status.pb }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  write_bitstream -force Nexys4fpga.bit 
  if { [file exists C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.runs/synth_1/Nexys4fpga.hwdef] } {
    catch { write_sysdef -hwdef C:/Users/Colten/Dropbox/_SCHOOL/ECE_540_SoC_Design/Final_Project/Labyrinth_viv/Labyrinth_viv.runs/synth_1/Nexys4fpga.hwdef -bitfile Nexys4fpga.bit -meminfo Nexys4fpga.mmi -file Nexys4fpga.sysdef }
  }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

