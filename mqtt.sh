#!/bin/bash

declare -A items

trimmedItem=${1:1}

#Misterhouse Item -> OpenHab Item
items["Bookshelf"]=Bookshelf_Light
#items["Pool_Light"]=Pool_Light
#items["Master_Fan"]=
#items["Master_Light"]=
items["Landscape_Lights"]=Landscape_Light
#items[""]=

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
