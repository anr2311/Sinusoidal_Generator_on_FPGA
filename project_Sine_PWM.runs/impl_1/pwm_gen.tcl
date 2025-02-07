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

set_msg_config -id {Common 17-41} -limit 10000000
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000

start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param xicom.use_bs_reader 1
  create_project -in_memory -part xc7z020clg484-1
  set_property board_part em.avnet.com:zed:part0:1.3 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir C:/Users/argo7/Desktop/project_Sine_PWM/project_Sine_PWM.cache/wt [current_project]
  set_property parent.project_path C:/Users/argo7/Desktop/project_Sine_PWM/project_Sine_PWM.xpr [current_project]
  set_property ip_output_repo C:/Users/argo7/Desktop/project_Sine_PWM/project_Sine_PWM.cache/ip [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  set_property XPM_LIBRARIES XPM_MEMORY [current_project]
  add_files -quiet C:/Users/argo7/Desktop/project_Sine_PWM/project_Sine_PWM.runs/synth_1/pwm_gen.dcp
  add_files -quiet c:/Users/argo7/Desktop/project_Sine_PWM/project_Sine_PWM.srcs/sources_1/ip/ila_0/ila_0.dcp
  set_property netlist_only true [get_files c:/Users/argo7/Desktop/project_Sine_PWM/project_Sine_PWM.srcs/sources_1/ip/ila_0/ila_0.dcp]
  read_xdc -mode out_of_context -ref ila_0 -cells inst c:/Users/argo7/Desktop/project_Sine_PWM/project_Sine_PWM.srcs/sources_1/ip/ila_0/ila_0_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/argo7/Desktop/project_Sine_PWM/project_Sine_PWM.srcs/sources_1/ip/ila_0/ila_0_ooc.xdc]
  read_xdc -ref ila_0 -cells inst c:/Users/argo7/Desktop/project_Sine_PWM/project_Sine_PWM.srcs/sources_1/ip/ila_0/ila_v6_2/constraints/ila.xdc
  set_property processing_order EARLY [get_files c:/Users/argo7/Desktop/project_Sine_PWM/project_Sine_PWM.srcs/sources_1/ip/ila_0/ila_v6_2/constraints/ila.xdc]
  read_xdc C:/Users/argo7/Desktop/project_Sine_PWM/project_Sine_PWM.srcs/constrs_1/new/constr.xdc
  link_design -top pwm_gen -part xc7z020clg484-1
  write_hwdef -file pwm_gen.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force pwm_gen_opt.dcp
  report_drc -file pwm_gen_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force pwm_gen_placed.dcp
  report_io -file pwm_gen_io_placed.rpt
  report_utilization -file pwm_gen_utilization_placed.rpt -pb pwm_gen_utilization_placed.pb
  report_control_sets -verbose -file pwm_gen_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force pwm_gen_routed.dcp
  report_drc -file pwm_gen_drc_routed.rpt -pb pwm_gen_drc_routed.pb -rpx pwm_gen_drc_routed.rpx
  report_methodology -file pwm_gen_methodology_drc_routed.rpt -rpx pwm_gen_methodology_drc_routed.rpx
  report_timing_summary -warn_on_violation -max_paths 10 -file pwm_gen_timing_summary_routed.rpt -rpx pwm_gen_timing_summary_routed.rpx
  report_power -file pwm_gen_power_routed.rpt -pb pwm_gen_power_summary_routed.pb -rpx pwm_gen_power_routed.rpx
  report_route_status -file pwm_gen_route_status.rpt -pb pwm_gen_route_status.pb
  report_clock_utilization -file pwm_gen_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force pwm_gen_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

start_step write_bitstream
set ACTIVE_STEP write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  set_property XPM_LIBRARIES XPM_MEMORY [current_project]
  catch { write_mem_info -force pwm_gen.mmi }
  write_bitstream -force -no_partial_bitfile pwm_gen.bit 
  catch { write_sysdef -hwdef pwm_gen.hwdef -bitfile pwm_gen.bit -meminfo pwm_gen.mmi -file pwm_gen.sysdef }
  catch {write_debug_probes -quiet -force debug_nets}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
  unset ACTIVE_STEP 
}

