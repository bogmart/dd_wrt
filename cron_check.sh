#!/bin/sh

############################################################
#
# cron_check_start
# https://svn.dd-wrt.com/ticket/4983
#
############################################################

RC=0

sleep 120

cron_err=`grep -m1 -E "cron.*ORPHAN" /var/log/messages`

if [ "${cron_err}" != "" ]; then
    stopservice cron
    sleep 1
    startservice cron
    RC=$?
fi

exit $RC

