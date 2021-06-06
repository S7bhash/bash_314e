#! /bin/sh

## Listing ESSIDS

iwlist wlp0s20f3 scan | grep ESSID | cut -d: -f2 >> network.txt


## listing names of connected networks

sudo cat /etc/NetworkManager/system-connections/fsociety.py.nmconnection | grep psk | cut -d= -f2 >> networks

## Deleting ruchishivani
sudo rm /etc/NetworkManager/system-connections/ruchishivani.nmconnection 
### however the won't br removed from this script as privilege need to be escaled












