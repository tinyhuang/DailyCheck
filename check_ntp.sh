#!/bin/bash
set -x
today=`date +%Y%m%d`
report_file="/tmp/DailyCheck_${today}.txt"
username=$1
servername=$2
check_type=$3

function check_ntp {
    echo "checking time offset status in $servername" >> ${report_file}
    ssh $username@$servername '/usr/sbin/ntpq -p' >>  ${report_file}
    echo "########################" >>  ${report_file}
}

function check_disk_usage {
    echo "checking disk usage status in $servername" >> ${report_file}
    ssh $username@$servername  'df -h | grep orlu' >>  ${report_file}
    echo "########################" >>  ${report_file}
}

if [ $3 = "time" ]
then
    check_ntp
elif [ $3 = "disk" ]
then
    check_disk_usage
fi

    

