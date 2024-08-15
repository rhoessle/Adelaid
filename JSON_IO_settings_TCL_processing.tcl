

# package require Tcl 8.4
package require json

set  json_file "/home/ralf/Schreibtisch/Programming_Language/Python/Python_Learning/Python_Files/converters/Fiorano/Settings/EXCELtoJSON_IO_settings.json"
if {[catch {set fp [open $json_file r]}]} {
    puts "The provided json file does not exist! $json_file"
    return
}
set fdata [read $fp]
close       $fp
set dct_json_settings [::json::json2dict $fdata]		;# here the JSON data are converted into a dictionary format

dict keys $dct_json_settings
# CFSB_A CFSB_G CLK32K_IN CLK32K_SOC_A

dict keys [ dict get $dct_json_settings CFSB_A ]
# IO_name_pattern IO_prog_path sim_dout_analog reg_CFG9_en_res_pullup

#------------------------------------------------------------------------------------------

# extract the instances (IOs)
foreach dct_json_inst  [dict keys $dct_json_settings] {
    puts    "$dct_json_inst"
    lappend list_INST  $dct_json_inst
}

# print the instances
foreach inst $list_INST {
    puts "\"$inst\""
}

#------------------------------------------------------------------------------------------

# set list_INST [list "GPIO1_AO"]

# fill spec_...
foreach inst $list_INST {
  # my variable spec_type
  foreach setting [ dict keys [ dict get $dct_json_settings $inst ] ] {
      # my variable $sparameter
      set $parameter [ dict get $dct_json_settings $inst $setting ]
      puts "set $parameter [set $parameter]]"
  }
}

#------------------------------------------------------------------------------------------

# set list_INST [list "GPIO1_AO"]

# fill spec_...
foreach inst $list_INST {
  # my variable spec_type
  set megacell         [dict get $dct_json_settings $inst "megacell"       ]
  set IO_name_pattern  [dict get $dct_json_settings $inst "IO_name_pattern"]
  set IO_prog_path     [dict get $dct_json_settings $inst "IO_prog_path"]
  puts "megacell: .......... $megacell "
  puts "IO_name_pattern: ... $IO_name_pattern"
  puts "IO_prog_path: ...... $IO_prog_path"
}

#------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------
# in context with  EXCELtoJSON_IO_pins.json  to build up waveforms
#------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------

# package require Tcl 8.4
package require json

set  json_file "/home/ralf/Schreibtisch/Programming_Language/Python/Python_Learning/Python_Files/converters/Fiorano/Settings/EXCELtoJSON_IO_settings.json"
if {[catch {set fp [open $json_file r]}]} {
    puts "The provided json file does not exist! $json_file"
    return
}
set fdata [read $fp]
close       $fp
set dct_json_settings [::json::json2dict $fdata]		;# here the JSON data are converted into a dictionary format

#---------------

set  json_file "/home/ralf/Schreibtisch/Programming_Language/Python/Python_Learning/Python_Files/converters/Fiorano/Settings/EXCELtoJSON_IO_pins.json"
if {[catch {set fp [open $json_file r]}]} {
    puts "The provided json file does not exist! $json_file"
    return
}
set fdata [read $fp]
close       $fp
set dct_json_pins [::json::json2dict $fdata]		;# here the JSON data are converted into a dictionary format

#---------------

set  json_file "/home/ralf/Schreibtisch/Programming_Language/Python/Python_Learning/Python_Files/converters/Fiorano/Settings/EXCELtoJSON_IO_mux.json"
if {[catch {set fp [open $json_file r]}]} {
    puts "The provided json file does not exist! $json_file"
    return
}
set fdata [read $fp]
close       $fp
set ::dct_json_mux [::json::json2dict $fdata]		;# here the JSON data are converted into a dictionary format

#---------------

# extract the instances (IOs)
foreach dct_json_inst  [dict keys $dct_json_settings] {
    puts    "$dct_json_inst"
    lappend list_INST  $dct_json_inst
}

#---------------


set inst "GPIO1_AO"

set megacell [dict get $dct_json_settings $inst "megacell"       ]
if {[dict exists $dct_json_pins $megacell sim_dout ]} {
  set value [ value [subst [dict get $dct_json_pins $megacell sim_dout ]]]
  puts "$inst dout value: $value"
}

# set list_INST [list "GPIO1_AO"]

# print instance (INST/IO) signals
foreach inst $list_INST {
  # my variable spec_type
  set megacell         [dict get $dct_json_settings $inst "megacell"       ]
  set IO_name_pattern  [dict get $dct_json_settings $inst "IO_name_pattern"]
  set IO_prog_path     [dict get $dct_json_settings $inst "IO_prog_path"]
  puts "megacell: .......... $megacell "
  puts "IO_name_pattern: ... $IO_name_pattern"
  puts "IO_prog_path: ...... $IO_prog_path"

  if {[dict exists $dct_json_pins     $megacell sim_din                            ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_din           ]] -group $inst " }
  if {[dict exists $dct_json_pins     $megacell sim_dout                           ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_dout          ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_drv_sel                        ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_drv_sel       ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_out_hs_en                      ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_out_hs_en     ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_out_ls_en                      ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_out_ls_en     ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_PAD                            ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_PAD           ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_pu_en                          ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_pu_en         ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_pd_en                          ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_pd_en         ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_por_n_vdd1                     ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_por_n_vdd1    ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_por_n_vdd2                     ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_por_n_vdd2    ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_por_n_vdd_ana                  ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_por_n_vdd_ana ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_sel_r                          ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_sel_r         ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_sel_vdd                        ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_sel_vdd       ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_sel_vdd_in_dig                 ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_sel_vdd_in_dig]]" }
  if {[dict exists $dct_json_pins     $megacell sim_VDD0                           ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_VDD0          ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_VDD1                           ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_VDD1          ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_VDD2                           ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_VDD2          ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_VDD3                           ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_VDD3          ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_VDD_MAIN                       ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_VDD_MAIN      ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_VDDIN_5V                       ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_VDDIN_5V      ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_VDD_1V2_AON                    ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_VDD_1V2_AON   ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_VDD_DIG                        ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_VDD_DIG       ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_VSS                            ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_VSS           ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_pad_internal                   ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_pad_internal  ]]" }
  if {[dict exists $dct_json_pins     $megacell sim_pad_protected                  ]} { puts "plotV [subst [dict get $dct_json_pins $megacell sim_pad_protected ]]" }
  if {[dict exists $dct_json_settings $inst     reg_CFG1_sel_supply                ]} { puts "plotV [xxx [dict get $dct_json_settings $inst reg_CFG1_sel_supply               ]]" }
  if {[dict exists $dct_json_settings $inst     reg_CFG9_en_output                 ]} { puts "plotV [xxx [dict get $dct_json_settings $inst reg_CFG9_en_output                ]]" }
  if {[dict exists $dct_json_settings $inst     reg_CFG9_sel_output_type           ]} { puts "plotV [xxx [dict get $dct_json_settings $inst reg_CFG9_sel_output_type          ]]" }
  if {[dict exists $dct_json_settings $inst     reg_CFG9_sel_output_opendrain_type ]} { puts "plotV [xxx [dict get $dct_json_settings $inst reg_CFG9_sel_output_opendrain_type]]" }
  if {[dict exists $dct_json_settings $inst     reg_CFG5_sel_gpoutput_function     ]} { puts "plotV [xxx [dict get $dct_json_settings $inst reg_CFG5_sel_gpoutput_function    ]]" }
  if {[dict exists $dct_json_settings $inst     reg_CFG0_sel_output_drv            ]} { puts "plotV [xxx [dict get $dct_json_settings $inst reg_CFG0_sel_output_drv           ]]" }
  if {[dict exists $dct_json_settings $inst     reg_CFG9_en_input                  ]} { puts "plotV [xxx [dict get $dct_json_settings $inst reg_CFG9_en_input                 ]]" }
  if {[dict exists $dct_json_settings $inst     reg_CFG9_en_res_pullup             ]} { puts "plotV [xxx [dict get $dct_json_settings $inst reg_CFG9_en_res_pullup            ]]" }
  if {[dict exists $dct_json_settings $inst     reg_CFG9_en_res_pulldn             ]} { puts "plotV [xxx [dict get $dct_json_settings $inst reg_CFG9_en_res_pulldn            ]]" }
  if {[dict exists $dct_json_settings $inst     reg_CFG0_sel_res                   ]} { puts "plotV [xxx [dict get $dct_json_settings $inst reg_CFG0_sel_res                  ]]" }

}

proc exec_test { test_name } {
  set io_signal      [ dict get $::dct_json_mux $test_name signal  ]
  set mux_in_signal  ""
  set mux_out_signal ""
  set app_mux        [ dict get $::dct_json_mux $test_name app_mux ]
  set channel        [ dict get $::dct_json_mux $test_name channel ]
  spmi reg_mux       $app_mux
  spmi reg_channel   $channel
  chk $io_signal $mux_in_signal
  chk $io_signal $mux_out_signal
}

#for {set i 1} {$i <= 48} {incr i} {
#    puts "expand \[ dict get \$::dct_json_mux test${i} io \]; exec_test test${i} ; collapse \[ dict get \$::dct_json_mux test${i} io \]"
#}

expand [ dict get $::dct_json_mux test1 io ]; exec_test test1 ; collapse [ dict get $::dct_json_mux test1 io ]
expand [ dict get $::dct_json_mux test2 io ]; exec_test test2 ; collapse [ dict get $::dct_json_mux test2 io ]
expand [ dict get $::dct_json_mux test3 io ]; exec_test test3 ; collapse [ dict get $::dct_json_mux test3 io ]
expand [ dict get $::dct_json_mux test4 io ]; exec_test test4 ; collapse [ dict get $::dct_json_mux test4 io ]
expand [ dict get $::dct_json_mux test5 io ]; exec_test test5 ; collapse [ dict get $::dct_json_mux test5 io ]
expand [ dict get $::dct_json_mux test6 io ]; exec_test test6 ; collapse [ dict get $::dct_json_mux test6 io ]
expand [ dict get $::dct_json_mux test7 io ]; exec_test test7 ; collapse [ dict get $::dct_json_mux test7 io ]
expand [ dict get $::dct_json_mux test8 io ]; exec_test test8 ; collapse [ dict get $::dct_json_mux test8 io ]
expand [ dict get $::dct_json_mux test9 io ]; exec_test test9 ; collapse [ dict get $::dct_json_mux test9 io ]
expand [ dict get $::dct_json_mux test10 io ]; exec_test test10 ; collapse [ dict get $::dct_json_mux test10 io ]
expand [ dict get $::dct_json_mux test11 io ]; exec_test test11 ; collapse [ dict get $::dct_json_mux test11 io ]
expand [ dict get $::dct_json_mux test12 io ]; exec_test test12 ; collapse [ dict get $::dct_json_mux test12 io ]
expand [ dict get $::dct_json_mux test13 io ]; exec_test test13 ; collapse [ dict get $::dct_json_mux test13 io ]
expand [ dict get $::dct_json_mux test14 io ]; exec_test test14 ; collapse [ dict get $::dct_json_mux test14 io ]
expand [ dict get $::dct_json_mux test15 io ]; exec_test test15 ; collapse [ dict get $::dct_json_mux test15 io ]
expand [ dict get $::dct_json_mux test16 io ]; exec_test test16 ; collapse [ dict get $::dct_json_mux test16 io ]
expand [ dict get $::dct_json_mux test17 io ]; exec_test test17 ; collapse [ dict get $::dct_json_mux test17 io ]
expand [ dict get $::dct_json_mux test18 io ]; exec_test test18 ; collapse [ dict get $::dct_json_mux test18 io ]
expand [ dict get $::dct_json_mux test19 io ]; exec_test test19 ; collapse [ dict get $::dct_json_mux test19 io ]
expand [ dict get $::dct_json_mux test20 io ]; exec_test test20 ; collapse [ dict get $::dct_json_mux test20 io ]
expand [ dict get $::dct_json_mux test21 io ]; exec_test test21 ; collapse [ dict get $::dct_json_mux test21 io ]
expand [ dict get $::dct_json_mux test22 io ]; exec_test test22 ; collapse [ dict get $::dct_json_mux test22 io ]
expand [ dict get $::dct_json_mux test23 io ]; exec_test test23 ; collapse [ dict get $::dct_json_mux test23 io ]
expand [ dict get $::dct_json_mux test24 io ]; exec_test test24 ; collapse [ dict get $::dct_json_mux test24 io ]
expand [ dict get $::dct_json_mux test25 io ]; exec_test test25 ; collapse [ dict get $::dct_json_mux test25 io ]
expand [ dict get $::dct_json_mux test26 io ]; exec_test test26 ; collapse [ dict get $::dct_json_mux test26 io ]
expand [ dict get $::dct_json_mux test27 io ]; exec_test test27 ; collapse [ dict get $::dct_json_mux test27 io ]
expand [ dict get $::dct_json_mux test28 io ]; exec_test test28 ; collapse [ dict get $::dct_json_mux test28 io ]
expand [ dict get $::dct_json_mux test29 io ]; exec_test test29 ; collapse [ dict get $::dct_json_mux test29 io ]
expand [ dict get $::dct_json_mux test30 io ]; exec_test test30 ; collapse [ dict get $::dct_json_mux test30 io ]
expand [ dict get $::dct_json_mux test31 io ]; exec_test test31 ; collapse [ dict get $::dct_json_mux test31 io ]
expand [ dict get $::dct_json_mux test32 io ]; exec_test test32 ; collapse [ dict get $::dct_json_mux test32 io ]
expand [ dict get $::dct_json_mux test33 io ]; exec_test test33 ; collapse [ dict get $::dct_json_mux test33 io ]
expand [ dict get $::dct_json_mux test34 io ]; exec_test test34 ; collapse [ dict get $::dct_json_mux test34 io ]
expand [ dict get $::dct_json_mux test35 io ]; exec_test test35 ; collapse [ dict get $::dct_json_mux test35 io ]
expand [ dict get $::dct_json_mux test36 io ]; exec_test test36 ; collapse [ dict get $::dct_json_mux test36 io ]
expand [ dict get $::dct_json_mux test37 io ]; exec_test test37 ; collapse [ dict get $::dct_json_mux test37 io ]
expand [ dict get $::dct_json_mux test38 io ]; exec_test test38 ; collapse [ dict get $::dct_json_mux test38 io ]
expand [ dict get $::dct_json_mux test39 io ]; exec_test test39 ; collapse [ dict get $::dct_json_mux test39 io ]
expand [ dict get $::dct_json_mux test40 io ]; exec_test test40 ; collapse [ dict get $::dct_json_mux test40 io ]
expand [ dict get $::dct_json_mux test41 io ]; exec_test test41 ; collapse [ dict get $::dct_json_mux test41 io ]
expand [ dict get $::dct_json_mux test42 io ]; exec_test test42 ; collapse [ dict get $::dct_json_mux test42 io ]
expand [ dict get $::dct_json_mux test43 io ]; exec_test test43 ; collapse [ dict get $::dct_json_mux test43 io ]
expand [ dict get $::dct_json_mux test44 io ]; exec_test test44 ; collapse [ dict get $::dct_json_mux test44 io ]
expand [ dict get $::dct_json_mux test45 io ]; exec_test test45 ; collapse [ dict get $::dct_json_mux test45 io ]
expand [ dict get $::dct_json_mux test46 io ]; exec_test test46 ; collapse [ dict get $::dct_json_mux test46 io ]
expand [ dict get $::dct_json_mux test47 io ]; exec_test test47 ; collapse [ dict get $::dct_json_mux test47 io ]
expand [ dict get $::dct_json_mux test48 io ]; exec_test test48 ; collapse [ dict get $::dct_json_mux test48 io ]


