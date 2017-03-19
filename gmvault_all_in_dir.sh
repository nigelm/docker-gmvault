#!/bin/sh
#
# Run gmvault on one all directories in the given directory
#

base_directory=${1:-/data}

if [ -d "${base_directory}" ]; then
    if [ -d "${base_directory}/.scripts" ]; then
        export PATH=$PATH:${base_directory}/.scripts
    fi
    for dir in ${base_directory}/*; do
        if [ -d ${dir} ]; then
            gmvault_one_account.sh ${dir}
            echo;echo;echo
        fi
    done
else
    echo "Base directory incorrect"
fi

