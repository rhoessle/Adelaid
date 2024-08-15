

# package require Tcl 8.4
package require json

set  json_file "/home/ralf/Schreibtisch/Programming_Language/Python/Python_Learning/Python_Files/converters/Fiorano/Settings/EXCELtoJSON_IO_mux.json"
if {[catch {set fp [open $json_file r]}]} {
    puts "The provided json file does not exist! $json_file"
    return
}
set fdata [read $fp]
close       $fp
set dct_json_mux [::json::json2dict $fdata]		;# here the JSON data are converted into a dictionary format

dict keys $dct_json_mux
# test1 test2 test3

dict get $dct_json_mux test1
# signal sim_fiorano.Ichip.Idcore.DCORE.apc_top_dig.apc_gcb.apc_pads.apc_pads_schematic.GATEFIXED_GPIO9_HV channel 0 app_mux 1

dict keys [ dict get $dct_json_mux test1 ]
# signal channel app_mux

dict get $dct_json_mux test1 signal
# sim_fiorano.Ichip.Idcore.DCORE.apc_top_dig.apc_gcb.apc_pads.apc_pads_schematic.GATEFIXED_GPIO9_HV

dict get $dct_json_mux test1 app_mux
# 1

dict get $dct_json_mux test1 channel
# 0


