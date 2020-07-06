#!/bin/bash -e
#
# Get patching level by querying the dpkg.log and apt/history.log to get information on new and upgrade packages
# dpkg logs will detail installation of any debian package but doesn't include information on where that package was 
# retrieved from. Apt will contain details about the repository that the package was pulled from in addition to its 
# installation on the system. 
# Refs:
# https://stackoverflow.com/questions/23705358/i-need-to-find-out-what-patches-have-been-installed-on-my-ubuntu
# https://unix.stackexchange.com/questions/104592/what-is-the-difference-between-apt-get-and-dpkg

echo "Get patch levels - Copying dpkg.log and apt history.log to output"

cp /var/log/dpkg.log ./output/dpkg.log
cp /var/log/apt/history.log ./output/apthistory.log