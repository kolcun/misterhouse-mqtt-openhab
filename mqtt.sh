#!/bin/bash

declare -A items

trimmedItem=${1:1}

#Misterhouse Item -> OpenHab Item
items["Bookshelf"]=Bookshelf_Light
items["Landscape_Lights"]=Landscape_Light
items["Laundry_Room_Lights"]=Laundry_Room
items["Family_Room_Main_Pot_Lights"]=Family_Room
items["Family_Room_Fireplace_Pot_Lights"]=Family_Room_Fireplace
items["Family_Room_Window_Pot_Lights"]=Family_Room_Accent
items["Living_Room_Pot_Lights"]=Living_Room_Accent
items["Front_Door_Keypad_Ext_Light"]=Exterior_Lights
items["Upstairs_Landing_Keypad_Light"]=Upstairs_Lights
items["Basement_Stairs_Top"]=Basement_Foyer
items["Front_Hall_Hall_Side"]=Main_Hallway
items["Pool_Gas_Heater"]=Pool_Heater



#look for an item in the map
item=${items[$trimmedItem]}

#if not in the map, use the item as it was passed in
if [[ $item = "" ]]
then
	item=$trimmedItem
fi

state=$2

#make sure our states are capitalized for openhab
if [[ $2 = "on" ]]
then
	state="ON"
fi
if [[ $2 = "off" ]]
then
        state="OFF"
fi

#if state has the percentage, strip it off
if [[ $state == *"%"* ]]; then
	state=${2%?}
fi


if ! [[ ! $item ]]; then
	`mosquitto_pub -h 52.90.29.252 -u kolcun -P MosquittoMQTTPassword\\$isVeryLong123 -t kolcun/indoor/openhab/in/$item/state -m $state`
	echo "exec $0 :: $item :: $state"
fi
