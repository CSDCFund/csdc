#!/bin/bash
# install nodejs
#cd wifi-setup

USER=$(whoami)

DATADIR="/mnt/massdisk"

sudo sed -i '/FallbackDNS/cFallbackDNS=114.114.114.114'  /etc/systemd/resolved.conf

sudo apt update
sudo systemctl restart systemd-resolved

sudo ./setup_wifi.sh


ech " now setting ip forward"

sudo sed -i "/net.ipv4.ip_forward/cnet.ipv4.ip_forward=1" /etc/sysctl.conf

sudo ./setup_nodejs.sh

npm config set registry https://registry.npm.taobao.org

# install pm2
pm2_exist=`whereis pm2 |awk -F ":" '{print $2}'`
if [[ $pm2_exist != "" ]]
then
echo "check pm2: $pm2_exist"
else
sudo npm install -g pm2
 pm2 install  pm2-logrotate
fi
pm2 delete all 
./clear_supwd.sh



sudo tar -xvzf ./cdsc-linux-amd64.tar.gz -C /usr/local/


sudo mkdir -p ${DATADIR}

sudo chown -R  $USER:$USER ${DATADIR}

sudo chown -R $USER:$USER /home/userroot
pm2 startup
cd /usr/local/cdsc/
pm2 delete cdsc_daemon
pm2  start /usr/local/cdsc/cdsc_daemon

pm2 save

