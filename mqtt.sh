#!/bin/bash

declare -A items

items["\$Bookshelf"]=Bookshelf_Light
items["\$Pool_Light"]=Pool_Light

item=${items[$1]}

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
