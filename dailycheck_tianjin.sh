#/bin/bash
#Introduction:daily check script
#Description:help me to get the servers' status, including time offset and disk usage  from Tianjin servers
#welcome to send mail to me james.huang@volvo.com
#usage: ./dailycheck_tianjin.sh

##################################################
#James Huang 2013-03-08
#setup the basic function to check time offset and disk usage
#still needs to add DataGurard status check

set -x
#define common variable
user="v0cn344"
date_check=`date +%Y%m%d`
file_report="/tmp/DailyCheck_${date_check}.txt"
file_server_list="server_ct_china.txt"

if [ -e ${file_report} ]
then
    rm ${file_report}
fi

touch ${file_report}

for servers_ct_china in `cat ./${file_server_list}`
do
    #check time offset status
    ./dailycheck_tianjin.exp ${user} ${servers_ct_china} time
done

for servers_ct_china in `cat ./${file_server_list} | grep -i db`
do
    #check oracle disk usage
    ./dailycheck_tianjin.exp ${user} ${servers_ct_china} disk
done




