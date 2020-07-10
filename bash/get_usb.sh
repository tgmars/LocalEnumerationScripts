#!/bin/bash -e
# 
# Note! Old versions of dmesg don't support the -T flag.
# Refs:
# https://stackoverflow.com/questions/13890789/convert-dmesg-timestamp-to-custom-date-format

# Using Allen Belletti's answer in the above SO link to convert the dmesg kernel uptimeseconds 
# to a usable time format.
dmesg_with_human_timestamps () {
    FORMAT="%a %b %d %H:%M:%S %Y"

    now=$(date +%s)
    cputime_line=$(grep -m1 "\.clock" /proc/sched_debug)

    if [[ $cputime_line =~ [^0-9]*([0-9]*).* ]]; then
        cputime=$((BASH_REMATCH[1] / 1000))
    fi

    dmesg | while IFS= read -r line; do
        if [[ $line =~ ^\[\ *([0-9]+)\.[0-9]+\]\ (.*) ]]; then
            stamp=$((now-cputime+BASH_REMATCH[1]))
            echo "[$(date +"${FORMAT}" --date=@${stamp})] ${BASH_REMATCH[2]}"
        else
            echo "$line"
        fi
    done
}
dmesg_with_human_timestamps | grep -i usb > ./output/usb_history.txt
