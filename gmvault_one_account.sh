#!/bin/sh
#
# Run gmvault on one directory/account
# Directory contains gmvault config files for the account,
# plus a file called email_address conating the associated email address
# and a directory db which will contain the gmvault db
#

if [ "$1" != "" ]; then
    base_directory=$1
    if [ -d "${base_directory}" -a -f "${base_directory}/email_address" ]; then
        email_address=`cat "${base_directory}/email_address"`
        db_directory="${base_directory}/db"
        [ -d ${db_directory} ] || mkdir ${db_directory}
        export GMVAULT_DIR=${base_directory}
        gmvault sync \
            --db-dir ${db_directory} \
            --type quick \
            --check-db no \
            ${email_address} | \
        sed -e '/^Process email num/ d' \
            -e '/^== Processed [0-9]*[1-9][0-9] emails in/ d' \
            -e '/^== Processed [0-9]*[1-9]00 emails in/ d' \
            -e '/^== Processed [0-9]*[1-9]000 emails in/ d' \
            -e '/^$/ d'
    fi
else
    echo "No directory to process given"
fi

