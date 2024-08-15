
# cd /home/ralf/Schreibtisch/Programming_Language/Python/Python_Learning/Python_Files/converters/Fiorano

#------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------

# package require Tcl 8.4
package require TclOO
package require json

catch { IO  destroy }

# create a new class
oo::class create IO {
  variable name

  constructor {} {
     # set variable: name to the object name without prefix inst_
     regsub {\:\:inst_} [self] {} name ;
  }
}

# print the instances
foreach inst $list_INST {
    puts "\"$inst\""
}

#----

# method to create the SDS variables in the object
#  from JSON file .../converters/Fiorano/SDS/EXCELtoJSON_SDS.json
#  variables will have the prefix spec_ and will be placed in a dictionary
oo::define IO method create_SDS_vars { dct_json_content_SDS  inst } {
    my variable {*}[info object vars [self]]
    set spec_type [ dict get $dct_json_content_SDS $inst type ]
    puts " set spec_type $spec_type"
    foreach spec_par [ dict keys [ dict get $dct_json_content_SDS $inst spec ] ] {
      # create the new variable on the fly
      my variable spec_$spec_par
      # fill the variable with content
      set min      [ dict get $dct_json_content_SDS $inst spec $spec_par Min     ]
      set typ      [ dict get $dct_json_content_SDS $inst spec $spec_par Typ     ]
      set max      [ dict get $dct_json_content_SDS $inst spec $spec_par Max     ]
      set unit     [ dict get $dct_json_content_SDS $inst spec $spec_par Unit    ]
      set reg_val  [ dict get $dct_json_content_SDS $inst spec $spec_par setting ]
      # if { [ expr {$typ ne "NaN"} ] } {
        #puts " set spec_$spec_par [list min $min typ $typ max $max unit $unit reg_val $reg_val]"
        puts "set spec_$spec_par \[dict create min $min typ $typ max $max unit $unit reg_val $reg_val\]"
        set spec_$spec_par [dict create min $min typ $typ max $max unit $unit reg_val $reg_val]
      # }
    }
}

#----

# method to create the SDS variables in the object
#  from JSON file .../converters/Fiorano/Settings/EXCELtoJSON_IO_settings.json
#  variables will have the prefix spec_ and will be placed in a dictionary
oo::define IO method create_settings_vars { dct_json_content_settings inst } {
    my variable {*}[info object vars [self]]
    foreach setting [ dict keys [ dict get $dct_json_content_settings $inst ] ] {
      my variable $setting
      set $setting [ dict get $dct_json_content_settings $inst $setting ]
      puts "set $setting [set $setting]"
    }
}

#----

# method to create the settings variables in the object
#  from JSON file /converters/Fiorano/Settings/EXCELtoJSON_IO_pins.json
oo::define IO method create_pins_vars { dct_json_content_pins inst } {
    my variable {*}[info object vars [self]]
    # fetch the dictionary content according the $megacell type
    #   $megacell is know from previous done setting of this variable
    foreach setting [ dict keys [ dict get $dct_json_content_pins $megacell ] ] {
      my variable $setting
      set $setting [ dict get $dct_json_content_settings $inst $setting ]
      puts "set $setting [set $setting]"
    }
}

#----

oo::define IO method show_vars { } {
    my variable {*}[info object vars [self]]
    foreach var [list {*}[info object vars [self]]] {
       puts  "${var}: [set ${var}]"
    }
}

#----

oo::define IO method get_var { var_name } {
    my variable {*}[info object vars [self]]
    #puts "{$var_name}: [set $var_name]"
    return [set $var_name]
}

#----

oo::define IO method set_var { var_name var_value } {
    my variable {*}[info object vars [self]]
    my variable $var_name                    ;# here the new variable is created on the fly
    set $var_name $var_value
}

#----

oo::define IO method get_dict { dct args } {
    my variable {*}[info object vars [self]]
    puts "[dict get [set  $dct] {*}$args]"
}

#----

oo::define IO method set_dict { dct args } {
    my variable {*}[info object vars [self]]
    dict set $dct {*}$args
}

#----

oo::define IO method extraxt_spec_lst_supply_voltages { } {
    my variable {*}[info object vars [self]]
    my variable spec_lst_supply_voltages ;# create the new variable here
    set spec_lst_supply_voltages [list ]
    foreach x {0 1 2 3} {
      set min [dict get [set spec_VDD$x] min]
      set typ [dict get [set spec_VDD$x] typ]
      set max [dict get [set spec_VDD$x] max]
      puts "spec_VDD$x min: $min , typ: $typ , max: $max: $max"
      if { [expr [expr {$min ne "NaN"}] && [expr {$typ ne "NaN"}] && [expr {$max ne "NaN"}]] } {
        lappend spec_lst_supply_voltages "VDD$x"
      }
    }
    puts "spec_lst_supply_voltages: $spec_lst_supply_voltages"
}

#----

oo::define IO method extraxt_spec_lst_drive_strengths { } {
    my variable {*}[info object vars [self]]
    my variable spec_lst_drive_strengths
    set spec_lst_drive_strengths [list ]
    foreach x {0 1 2 3 4 5 6 7} {
      set min [dict get [set spec_DRV_out_$x] min]
      set typ [dict get [set spec_DRV_out_$x] typ]
      set max [dict get [set spec_DRV_out_$x] max]
      puts "spec_DRV_out_$x min: $min , typ: $typ , max: $max: $max"
      if { [expr [expr {$min ne "NaN"}] && [expr {$typ ne "NaN"}] && [expr {$max ne "NaN"}]] } {
        lappend spec_lst_drive_strengths "DRV_out_$x"
      }
    }
    puts "spec_lst_drive_strengths: $spec_lst_drive_strengths"
}

#----

oo::define IO method extraxt_spec_lst_resistive_val { } {
    my variable {*}[info object vars [self]]
    my variable spec_lst_resistive_val
    set spec_lst_resistive_val [list ]
    foreach x {0 1 2 3} {
      set min [dict get [set spec_R_pu_pd_$x] min]
      set typ [dict get [set spec_R_pu_pd_$x] typ]
      set max [dict get [set spec_R_pu_pd_$x] max]
      puts "spec_R_pu_pd_$x min: $min , typ: $typ , max: $max: $max"
      if { [expr [expr {$min ne "NaN"}] && [expr {$typ ne "NaN"}] && [expr {$max ne "NaN"}]] } {
        lappend spec_lst_resistive_val "R_pu_pd_$x"
      }
    }
    puts "spec_lst_resistive_val: $spec_lst_resistive_val"
}

#----

# NOT used in project
oo::define IO method extraxt_spec_lst_slew_rates { } {
    my variable {*}[info object vars [self]]
    my variable spec_lst_slew_rates
    set spec_lst_slew_rates [list ]
    foreach x {0 1 2 3 5 6 7} {
      set min [dict get [set spec_SR_out_$x] min]
      set typ [dict get [set spec_SR_out_$x] typ]
      set max [dict get [set spec_SR_out_$x] max]
      puts "spec_SR_out__$x min: $min , typ: $typ , max: $max: $max"
      if { [expr [expr {$min ne "NaN"}] && [expr {$typ ne "NaN"}] && [expr {$max ne "NaN"}]] } {
        lappend spec_lst_slew_rates "SR_out_$x"
      }
    }
    puts "spec_lst_slew_rates: $spec_lst_slew_rates"
}

#------------------------------------------------------------------------------------------

set  json_file "/home/ralf/Schreibtisch/Programming_Language/Python/Python_Learning/Python_Files/converters/Fiorano/SDS/EXCELtoJSON_SDS.json"
if {[catch {set fp [open $json_file r]}]} {
    puts "The provided json file does not exist! $json_file"
    return
}
set fdata [read $fp]
close       $fp
set dct_json_content_SDS [::json::json2dict $fdata]

# dict get $dct_json_content_SDS GPIO1 type

# extract the instances (to get the instance list)
foreach dct_json_content_SDS  [dict keys $dct_json_content] {
    puts    "$dct_json_inst"
    lappend list_INST  $dct_json_inst
}
# GPIO1 GPIO2 GPIO3 #VALUE! None iolv iohv ilv iospmi

#------------------------------------------------------------------------------------------

set  json_file "/home/ralf/Schreibtisch/Programming_Language/Python/Python_Learning/Python_Files/converters/Fiorano/Settings/EXCELtoJSON_IO_settings.json"
if {[catch {set fp [open $json_file r]}]} {
    puts "The provided json file does not exist! $json_file"
    return
}
set fdata [read $fp]
close       $fp
set dct_json_content_settings [::json::json2dict $fdata]		;# here the JSON data are converted into a dictionary format

#------------------------------------------------------------------------------------------

set  json_file "/home/ralf/Schreibtisch/Programming_Language/Python/Python_Learning/Python_Files/converters/Fiorano/Settings/EXCELtoJSON_IO_pins.json"
if {[catch {set fp [open $json_file r]}]} {
    puts "The provided json file does not exist! $json_file"
    return
}
set fdata [read $fp]
close       $fp
set dct_json_content_pins [::json::json2dict $fdata]		;# here the JSON data are converted into a dictionary format

# dict get $dct_json_content_pins "apc_gpio_lv_2r" "pin_contol"
#   din 0 dout 0 drv_sel 0 in_en  0  out_hs_en  0  out_ls_en  0  pu_en  0  pd_en  0  sel_r  0  sel_vdd  0
# dict get $dct_json_content_pins "apc_gpio_lv_2r" "pin_contol" pu_en
#   0
# dict set dct_json_content_pins "apc_gpio_lv_2r" "pin_contol" pu_en 1
# dict get $dct_json_content_pins "apc_gpio_lv_2r" "pin_contol" pu_en
#   1

#----

oo::define IO method reset_pin_contol { } {
    # resets the dictionary variable key-values to 'NA'
    # Remark: dictionary pin_control has to exist
    my variable {*}[info object vars [self]]
    foreach key [dict keys $pin_control] {
      dict set pin_control $key 'NA'
    }
    puts "pin_control: $pin_controls"
}

#------------------------------------------------------------------------------------------

# set list_INST [list GPIO1]

# initialize
foreach inst $list_INST {
  # set inst GPIO1
  puts " create the IO object "
  catch { inst_$inst destroy }
  puts " [ IO create inst_$inst ]"
  # create the SDS variables
  inst_$inst create_SDS_vars      $dct_json_content_SDS      $inst
  inst_$inst create_settings_vars $dct_json_content_settings $inst
  inst_$inst create_pins_vars     $dct_json_content_pins     $inst
}

  inst_GPIO1 set_var megacell "apc_gpio_hv_4r"     ;# this variable should normally set in create_settings_vars
  inst_GPIO1 get_var megacell
  # apc_gpio_hv_4r

  inst_$inst create_pins_vars     $dct_json_content_pins     $inst

  # extract list spec_lst_supply_voltages
  inst_GPIO1 extraxt_spec_lst_supply_voltages
  inst_GPIO1 get_var spec_lst_supply_voltages
  # VDD0 VDD1

  # extract list spec_lst_drive_strengths
  inst_GPIO1 extraxt_spec_lst_drive_strengths
  inst_GPIO1 get_var spec_lst_drive_strengths
  # DRV_out_0 DRV_out_1 DRV_out_2 DRV_out_3

  # extract list spec_lst_resistive_val
  inst_GPIO1 extraxt_spec_lst_resistive_val
  inst_GPIO1 get_var spec_lst_resistive_val
  # R_pu_pd_0 R_pu_pd_1 R_pu_pd_2 R_pu_pd_3

  # extract list spec_lst_slew_rates
  inst_GPIO1 extraxt_spec_lst_slew_rates
  inst_GPIO1 get_var spec_lst_slew_rates
  # SR_out_0 SR_out_1 SR_out_2 SR_out_3



#------------------------------------------------------------------------------------------

inst_GPIO1 get_var name

inst_GPIO1 show_vars
# spec_SR_out_3: min 0.15 typ - max 2.65 unit V/ns reg_val 3
# spec_DRV_out_4: min - typ - max - unit mA reg_val 4
# spec_VDD0: min 1.08 typ 1.2 max 1.32 unit V reg_val 0

# fetch variable content ...
inst_GPIO1 get_var spec_VDD0
# min 1.08 typ 1.2 max 1.32 unit V reg_val 0

# fetch dictionary content ...
inst_GPIO1 get_dict spec_VDD0 min
# 1.08



