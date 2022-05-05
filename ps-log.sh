#!/bin/bash 
MaxFileSize=204800
DaysToKeep=7
echo -e "\n Fecha:"`date` >> /var/log/ps.log
echo -e "\n Uptime: "`uptime` >> /var/log/ps.log
ps -e -o pcpu,pmem,args --sort=pcpu | tail >> /var/log/ps.log
#Get size in bytes** 
file_size=`du -b /var/log/ps.log | tr -s '\t' ' ' | cut -d' ' -f1`
if [ $file_size -gt $MaxFileSize ];then   
    timestamp=`date +%s`
    mv /var/log/ps.log /var/log/ps.log.$timestamp
    gzip /var/log/ps.log.$timestamp
    touch /var/log/ps.log
    # remove old files
    find /var/log -name "ps.log.*" -type f -mtime +$DaysToKeep -delete 
fi
