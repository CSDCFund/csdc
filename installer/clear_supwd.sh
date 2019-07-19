#!/bin/bash
USER= "whoami"
NOPASSWD=`sudo cat /etc/sudoers | grep "$USER\ ALL=NOPASSWD:ALL"`
echo "user:$USER NOPASSWD:$NOPASSWD"

parameter="\$a${USER}\\ ALL=NOPASSWD:ALL"
if [[ $NOPASSWD == "" ]]
then 
echo $parameter
sudo  sed --in-place  "\$a${USER}\\ ALL=NOPASSWD:ALL" /etc/sudoers
else 
echo "nopassword ok"
fi

#echo "install exfat support"

