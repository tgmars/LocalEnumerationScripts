#!/bin/bash -e
#
# Get OS Version ... writes lsb_release info on the OS to osversion.csv
# and the uname to query hardware and kernel details to kernel.csv

# Split on colons in lsb_release output
IFS=':'
# Declare an array called headers, used to store the headers
declare -a headers
declare -a values

# Parse lsb_release -a output into arrays. 
# Strip whitespace from the values fields.
while IFS=':' read -a line ; do
    headers+=( ${line[0]} )
    # Strip whitespace away from values
    valueNoSpace="$(echo -e "${line[1]}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
    values+=( $valueNoSpace )
done < <( lsb_release -a )

# array_to_csv $1 ... echos an arrays values separated by columns on a single line
array_to_csv () {
    localArray=("$@")
    for index in "${localArray[@]}"; do printf "%s," $index >> ./output/osversion.csv; done
    printf "\n" >> ./output/osversion
}

# Write each of the 'rows' out to csv.
array_to_csv ${headers[@]}
array_to_csv ${values[@]}


IFS=
# Write kernel version out to kernel.csv
hostname=$(uname -n)
kernelName=$(uname -s)
kernelRelease=$(uname -r)
kernelVersion=$(uname -v)
machineArchitecture=$(uname -m)
printf "hostname,kernelname,kernelrelease,kernelversion,machinearchitecture\n%s,%s,%s,%s,%s" \
    "$hostname" "$kernelName" "$kernelRelease" "$kernelVersion" "$machineArchitecture" >> ./output/kernel.csv



# Refs:
# https://stackoverflow.com/questions/11426529/reading-output-of-a-command-into-an-array-in-bash