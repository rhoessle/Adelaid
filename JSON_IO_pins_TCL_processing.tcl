
# cd /home/ralf/Schreibtisch/Programming_Language/Python/Python_Learning/Python_Files/converters/Fiorano

# package require Tcl 8.4
package require json

set  json_file "/home/ralf/Schreibtisch/Programming_Language/Python/Python_Learning/Python_Files/converters/Fiorano/Settings/EXCELtoJSON_IO_pins.json"
if {[catch {set fp [open $json_file r]}]} {
    puts "The provided json file does not exist! $json_file"
    return
}
set fdata [read $fp]
close       $fp
set dct_json_pins [::json::json2dict $fdata]		;# here the JSON data are converted into a dictionary format

dict keys $dct_json_pins
# apc_gpio_lv_2r apc_gpio_hv_4r apcsp_gpi1v2_2r

dict get $dct_json_pins apc_gpio_lv_2r
# sim_din {${IO_name_pattern}.din_dig } sim_dout {${IO_name_pattern}.dout_dig } ...

dict get $dct_json_pins apc_gpio_lv_2r sim_din
# ${IO_name_pattern}.din_dig

# with ...
set IO_name_pattern  sim_fiorano.Ichip.Idcore.DCORE.apc_top_dig.apc_gcb.apc_pads.apc_pads_schematic.GATEFIXED_CFSB_A
puts "[dict get $dct_json_pins apc_gpio_lv_2r sim_din]"
# ${IO_name_pattern}.din_dig
puts "[subst [dict get $dct_json_pins apc_gpio_lv_2r sim_din] ]"
sim_fiorano.Ichip.Idcore.DCORE.apc_top_dig.apc_gcb.apc_pads.apc_pads_schematic.GATEFIXED_CFSB_A.din_dig

# @ key/value pair exists
dict exists $dct_json_pins apc_gpio_lv_2r sim_din
# 1
# @ key/value pair doesn't exist
dict exists $dct_json_pins apc_gpio_lv_2r sim_dinX
# 0
