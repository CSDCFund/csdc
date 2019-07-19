#!/bin/bash


diskValue=`  fdisk -l /dev/sd? |grep "Disk /dev" |awk '{print $2}' | awk -F [：:] '{print $1}'`

# echo "ALL data on $diskValue will be DESTROIED, will you continue to do that   ((N)o/(y)es)?"
#typeset -l answer
#read answer
#if [[ "$answer" =~ ^y(es)? ]]; then
    
#    echo "Please retype (CONFIRM) to continue this operation"
#typeset -l result
DISK=`sudo fdisk -l /dev/sd? |grep "Disk /dev" |awk '{print $2}' | awk -F [：:] '{print $1}' | awk -F [\/] '{print $3}'`

echo  "$DISK"

size=" $(cat /sys/block/${DISK}/queue/optimal_io_size)"
#echo "size $size"
offset=" $(cat /sys/block/${DISK}/alignment_offset)"
#echo "offset $offset"
sstart=$(expr $size / 512)
send=$(expr $offset / 512)
svalue=$(expr $sstart + $send)
#echo  "value:$svalue"
#read result
#    if [[ "$result" = "confirm" ]]; then
	    echo " rm 4
	    y 

	    rm 3
	    y

	    rm 2
	    y 

	    rm 1 

	    y

	    mklabel gpt
	    y
	    unit %

	    mkpart primary ext4 0% 100%
	    i
	    y	    
	    mkpart primary ext4 0% 100%
            y
	    i
	    quit

	    "|parted $diskvalue

     echo -e "disk has been created $diskValue"
        sleep 2s
        echo -e "Creating file system now:mkfs.ext4 ${diskValue}1"
        echo "y
       

	"	|mkfs.ext4  ${diskValue}1
     echo -e "disk fs created"
        #create a mount point
        if [ ! -d "/mnt/massdisk" ];then
        mkdir -p /mnt/massdisk
        fi

       mkdir -p /usr/local/cdsc

        uuid=$(dumpe2fs -h ${diskValue}1 |grep "Filesystem UUID:"|awk -F ": " '{print $2}' | sed 's/^[ \t]*//g')
        echo -e "$uuid" > /usr/local/cdsc/diskuuid.txt

         mount -tauto -orw -U $uuid /mnt/massdisk

#    else 
#        echo "you have denied a dangerous operation"
#    fi
#else 
#   echo "you have denied a dangerous operation"
#fi
