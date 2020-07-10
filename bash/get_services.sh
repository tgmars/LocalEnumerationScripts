#!/bin/bash -e
#
# Grab linux services known by service and initctl daemons.
# Refs:
# https://askubuntu.com/questions/407075/how-to-read-service-status-all-results

if [ -f "./output/services-services.txt" ]; then 
    rm ./output/services-services.txt
    touch ./output/services-services.txt
fi

sudo service --status-all >>./output/services-services.txt 2>&1
sudo initctl list > ./output/upstart-services.txt