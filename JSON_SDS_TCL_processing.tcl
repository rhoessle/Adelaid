

# package require Tcl 8.4
package require json

set  json_file "/home/ralf/Schreibtisch/Programming_Language/Python/Python_Learning/Python_Files/converters/Fiorano/SDS/EXCELtoJSON_SDS.json"
if {[catch {set fp [open $json_file r]}]} {
    puts "The provided json file does not exist! $json_file"
    return
}
set fdata [read $fp]
close       $fp
set dct_json_content [::json::json2dict $fdata]		;# here the JSON data are converted into a dictionary format

dict keys $dct_json_content
# GPIO1 GPIO2 GPIO3 #VALUE! None iolv iohv ilv iospmi

dict get $dct_json_content GPIO1 type
# apc_iolv
dict keys [ dict get $dct_json_content GPIO1 spec ]
# VDD0 VDD1 VDD2 VDD3 VDD3_name VDD_input1 VDD_input2 Vthr_pos Vthr_neg

dict get $dct_json_content GPIO1 spec VDD0
# Min 1.08 Typ 1.2 Max 1.32 Unit V primary_parameter {IO driver supply; setting 0} setting 0

dict exists $dct_json_content GPIO1
# 1
dict exists $dct_json_content GPIO1 spec VDD0 Min
# 1
dict exists $dct_json_content GPIO1 spec VDD0 MinX
# 0

#------------------------------------------------------------------------------------------

# extract the instances
foreach dct_json_inst  [dict keys $dct_json_content] {
    puts    "$dct_json_inst"
    lappend list_INST  $dct_json_inst
}

# print the instances
foreach inst $list_INST {
    puts "\"$inst\""
}

# set inst [list GPIO1 GPIO2 GPIO3]

# fill spec_...
foreach inst $list_INST {
  # my variable spec_type
  set spec_type [ dict get $dct_json_content $inst type ]
  puts " set spec_type $spec_type"
  foreach spec_par [ dict keys [ dict get $dct_json_content $inst spec ] ] {
      # my variable spec_$spec_par
      set min      [ dict get $dct_json_content $inst spec $spec_par Min     ]
      set typ      [ dict get $dct_json_content $inst spec $spec_par Typ     ]
      set max      [ dict get $dct_json_content $inst spec $spec_par Max     ]
      set unit     [ dict get $dct_json_content $inst spec $spec_par Unit    ]
      set reg_val  [ dict get $dct_json_content $inst spec $spec_par setting ]
      # if { [ expr {$typ ne "-"} ] } {
        #puts " set spec_$spec_par [list min $min typ $typ max $max unit $unit reg_val $reg_val]"
        set spec_$spec_par [list min $min typ $typ max $max unit $unit reg_val $reg_val]
      # }
  }
}

puts "[lindex $spec_R_pu_pd_3 0] "
# min
puts "[dict get $spec_R_pu_pd_3 min] "
# '-'
puts "$spec_type "

#------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------

# package require Tcl 8.4
package require TclOO
package require json

catch { IO  destroy }

# create a new class
oo::class create IO {
  constructor {} {
  }
}

# print the instances
foreach inst $list_INST {
    puts "\"$inst\""
}

#----

oo::define IO method create_SDS_vars { dct_json_content_SDS  inst } {
    my variable {*}[info object vars [self]]
    set spec_type [ dict get $dct_json_content_SDS $inst type ]
    puts " set spec_type $spec_type"
    foreach spec_par [ dict keys [ dict get $dct_json_content_SDS $inst spec ] ] {
      my variable spec_$spec_par
      set min      [ dict get $dct_json_content_SDS $inst spec $spec_par Min     ]
      set typ      [ dict get $dct_json_content_SDS $inst spec $spec_par Typ     ]
      set max      [ dict get $dct_json_content_SDS $inst spec $spec_par Max     ]
      set unit     [ dict get $dct_json_content_SDS $inst spec $spec_par Unit    ]
      set reg_val  [ dict get $dct_json_content_SDS $inst spec $spec_par setting ]
      # if { [ expr {$typ ne "-"} ] } {
        #puts " set spec_$spec_par [list min $min typ $typ max $max unit $unit reg_val $reg_val]"
        puts "set spec_$spec_par \[dict create min $min typ $typ max $max unit $unit reg_val $reg_val\]"
        set spec_$spec_par [dict create min $min typ $typ max $max unit $unit reg_val $reg_val]
      # }
    }
}

#----

oo::define IO method create_settings_vars { dct_json_content_settings inst } {
    my variable {*}[info object vars [self]]
    foreach inst $list_INST {
        foreach setting [ dict keys [ dict get $dct_json_content_settings $inst ] ] {
          my variable $setting
          set $setting [ dict get $dct_json_content_settings $inst $setting ]
          puts "set $setting [set $setting]"
        }
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

# extract the instances
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
}

#------------------------------------------------------------------------------------------

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




