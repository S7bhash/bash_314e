#! /bin/sh

## Commands used for getting hostname, MAC address and public ip

hostname

ifconfig wlp0s20f3 | grep ether | cut -d ' ' -f10

curl -s ifconfig.me
