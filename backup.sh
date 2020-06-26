#!/bin/bash

if [[ "$(id -u)" -eq "0" ]]; then

    backupname="backup_$(date +'%Y_%m_%d')"
    hashname="hashsums_$(date +'%Y_%m_%d')"

    mkdir $hashname
    echo "Hashing /etc"
    find /etc -type f -exec md5sum {} \; > "$hashname/etc.hash"

    echo "Hashing /var/log"
    find /var/log -type f  -exec md5sum {} \; > "$hashname/var_log.hash"

    echo "Hashing /var/lib"
    find /var/lib -type f -exec md5sum {} \; > "$hashname/var_lib.hash"

    echo "Hashing /boot"
    find /boot -type f -exec md5sum {} \; > "$hashname/boot.hash"

    echo "Hashing /bin"
    find /bin -type f -exec md5sum {} \; > "$hashname/bin.hash"

    tar -cvjpf $backupname /etc /var/log /boot /bin

    tar --remove-files -cvjpf $backupname.tar.bz $hashname $backupname

else
    echo "ERORR.The script can only be run by the root user"
fi
