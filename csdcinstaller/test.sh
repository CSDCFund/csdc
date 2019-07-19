
#!/bin/bash
DISK=`sudo fdisk -l /dev/sd? |grep "Disk /dev" |awk '{print $2}' | awk -F [：:] '{print $1}' | awk -F [\/] '{print $3}'`

echo  "$DISK"

size=" $(cat /sys/block/${DISK}/queue/optimal_io_size)"
echo "size $size"
offset=" $(cat /sys/block/${DISK}/alignment_offset)"
echo "offset $offset"
sstart=$(expr $size / 512)
send=$(expr $offset / 512)
svalue=$(expr $sstart + $send)
echo  "value:$svalue"

