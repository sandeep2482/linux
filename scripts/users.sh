#!/bin/bash
read -p "Enter a name:" name
read -p "Enter a office: SSNNN " office
dept=${office:0:2}
room=${office:2}
echo "Name $name"
echo "Department $dept"
echo "Room $room"
