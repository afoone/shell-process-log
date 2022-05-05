#!/bin/bash 
touch /var/log/ps.log
MaxFileSize=2048
echo -e "\n Fecha:"`date` >> /var/log/ps.log
ps -e -o pcpu,pmem,args --sort=pcpu | tail >> /var/log/ps.log
#Get size in bytes** 
file_size=`du -b /var/log/ps.log | tr -s '\t' ' ' | cut -d' ' -f1`
if [ $file_size -gt $MaxFileSize ];then   
    timestamp=`date +%s`
    mv /var/log/ps.log /var/log/ps.log.$timestamp
    touch /var/log/ps.log
fi
