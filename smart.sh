#!/bin/sh

/jffs/smartctl -d sat -a /dev/sda > /jffs/myLogs/smartctl/smart_`date +"%Y.%m.%d"`.txt

