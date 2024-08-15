#----------------------------------------------------------------------------------

# cd /home/ralf/Schreibtisch/Programming_Language/Python/Python_Learning/Python_Files/converters/Adelaid
# python3 JSONtoJSONall.py

import json
import yaml


file_in_json_EXCELtoJSON_IO_settings = '/home/ralf/Schreibtisch/Programming_Language/Python/Python_Learning/Python_Files/converters/Adelaid/Settings/EXCELtoJSON_IO_settings.json'
file_in_json_EXCELtoJSON_IO_DATA     = '/home/ralf/Schreibtisch/Programming_Language/Python/Python_Learning/Python_Files/converters/Adelaid/Settings/EXCELtoJSON_IO_DATA.json'

file_out_json = '/home/ralf/Schreibtisch/Programming_Language/Python/Python_Learning/Python_Files/converters/Adelaid/Settings/Adelaid_EXCELtoJSONall.json'
file_out_yaml = '/home/ralf/Schreibtisch/Programming_Language/Python/Python_Learning/Python_Files/converters/Adelaid/Settings/Adelaid_EXCELtoJSONall.yaml'

with open(file_in_json_EXCELtoJSON_IO_settings) as json_file:
    settings = json.load(json_file)

with open(file_in_json_EXCELtoJSON_IO_DATA) as json_file:
    data = json.load(json_file)

dict_all = {}
dict_all = settings

for IO in dict_all.keys():
    if dict_all[IO]["megacell"] == "apc_gpio_hv_4r":
        print(f"IO:    {IO}     type:       apc_gpio_hv_4r")
        dict_all[IO].update(data["apc_gpio_hv_4r"])
    if dict_all[IO]["megacell"] == "apc_gpio_lv_2r":
        print(f"IO:    {IO}     type:       apc_gpio_lv_2r")
        dict_all[IO].update(data["apc_gpio_hv_4r"])
    if dict_all[IO]["megacell"] == "apcsp_gpi1v2_2r":
        print(f"IO:    {IO}     type:       apcsp_gpi1v2_2r")
        dict_all[IO].update(data["apcsp_gpi1v2_2r"])

# Convert extracted data into JSON format
json_data = json.dumps(dict_all, indent=4)
with open(file_out_json, "w") as outfile:
    outfile.write(json_data)

# Convert extracted data into YAML format
yaml_data = yaml.dump(dict_all, indent=4)
with open(file_out_yaml, "w") as outfile:
    outfile.write(yaml_data)
