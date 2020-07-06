#!/bin/bash -e
#
# Uses dpkg to list installed packages on the system

# dpkgVar=$(dpkg --list)

# printf "%s\n" "$dpkgVar" > ./output/software.txt

# declare -a package
# declare -a version

# while read -a line ; do
#     if [ ${line[0]} = "ii" ]
#     then
#         package+=( ${line[1]} )
#         version+=( ${line[2]} )
#     fi
# done

# sed -e "s/ /,/g" < <( ps -ef )

# array_to_csv $1 ... echos an arrays values separated by columns on a single line

# printf "package,version\n" | tee ./output/software.csv

# for ((i=0; i<${#package[@]}; i++)); do
#     printf "%s,%s\n" "${package[i]}" "${version[i]}" | tee -a ./output/software.csv
# done

ps -ef > ./output/processes.txt
