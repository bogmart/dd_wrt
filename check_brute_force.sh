#!/bin/sh

############################################################
#
# check_brute_force
# Checks for failed logins and blocks IP addresses
#
############################################################

LOCAL_LAN=`ifconfig br0 | awk '/inet/ { print $2 }' | cut -d':' -f2 | cut -d'.' -f-3`

IP=`awk -F'[ :]' '/Login attempt|Bad password attempt/ {print $(NF-1)}' /var/log/messages | tail -1`
rc=0

# Do nothing if there is an existing rule for this IP address
if `iptables -L -n | grep $IP > /dev/null 2>&1`; then
    exit 0
fi

case $IP in
    "") # Do nothing with empty IP
    ;;
    ${LOCAL_LAN}*) # Exclude local LAN
    ;;
    *) # Add rule against intruding IP
    iptables -I INPUT -s $IP -j DROP
    RC=$?
    ;;
esac

exit $RC

# EOF
