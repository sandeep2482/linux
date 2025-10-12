#!/bin/bash
TODAY=$(date +%F)
read -p "Enter a name:" name
read -p "Enter a office: SSNNN " office
dept=${office:0:2}
room=${office:2}
echo "User Created on $TODAY"
echo "Name $name"
echo "Department $dept"
echo "Room $room"
