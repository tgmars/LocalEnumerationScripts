#!/bin/bash -e
#
# Refs:
# https://askubuntu.com/questions/407075/how-to-read-service-status-all-results

rm ./output/services-services.txt
touch ./output/services-services.txt

sudo service --status-all >>./output/services-services.txt 2>&1
sudo initctl list > ./output/upstart-services.txt