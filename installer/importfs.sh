diskValue=$1
uuid=$(dumpe2fs -h ${diskValue} |grep "Filesystem UUID:"|awk -F ": " '{print $2}' | sed 's/^[ \t]*//g')
echo "$uuid" > /usr/local/cdsc/diskuuid.txt
mkdir -p /mnt/massdisk
mount -tauto -orw -U $uuid /mnt/massdisk