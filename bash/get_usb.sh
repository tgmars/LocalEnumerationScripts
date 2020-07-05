#!/bin/bash -e
# 
dmesg | grep -i usb | tee ./output/usb_history.txt