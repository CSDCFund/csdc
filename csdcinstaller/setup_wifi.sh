#!/bin/bash
echo "setup wireless and run as ap"
apt install -y  wireless-tools hostapd isc-dhcp-server

cp ./hostapd.conf /etc/hostapd/hostapd.conf
#update ap SSID with machine-id
VAL=$(cat /etc/machine-id)

ssid=${VAL:0:6}
sed -i ''s/\${id}/${ssid}/g'' /etc/hostapd/hostapd.conf

echo "Your wireless AP is eswarm${ssid} and password is Abcd#1234"
# adding DAEMON_CONF="/etc/hostapd/hostapd.conf" to /etc/default/hostapd
sed -i 's/#DAEMON_CONF=""/DAEMON_CONF="\/etc\/hostapd\/hostapd\.conf"/g' /etc/default/hostapd

sed -i 's/INTERFACESv4=""/INTERFACESv4="wlp2s0"/g' /etc/default/isc-dhcp-server
sed -i 's/INTERFACESv6=""/INTERFACESv46="wlp2s0"/g' /etc/default/isc-dhcp-server

# config dhcp 
sed  -i 's/^option domain-name "example.org";/#option domain-name "example.org";/g' /etc/dhcp/dhcpd.conf
sed  -i 's/^option domain-name-servers ns1.example.org,/#option domain-name-servers ns1.example.org,/g' /etc/dhcp/dhcpd.conf

sed  -i 's/^default-lease-time 600;/#default-lease-time 600;/g' /etc/dhcp/dhcpd.conf

sed  -i  's/^max-lease-time 7200;/#max-lease-time 7200;/g' /etc/dhcp/dhcpd.conf

SubnetAdded=`cat /etc/dhcp/dhcpd.conf | grep "subnet 192.168.124.0 netmask 255.255.255.0"`
if [[ $SubnetAdded == "" ]]; then 
    cat dhcp.conf >> /etc/dhcp/dhcpd.conf
fi 
NetOk=`cat /etc/netplan/50-cloud-init.yaml | grep -n '^network\:'`
if [[ $NetOk == "" ]]; then 
 sed -i '/network:/ r np_network.conf' /etc/netplan/50-cloud-init.yaml
fi

EthOk=`cat /etc/netplan/50-cloud-init.yaml | grep "ethernets:"`
if [[ $EthOk == "" ]]; then 
 sed -i '/^network:/ r np_ethernets.conf' /etc/netplan/50-cloud-init.yaml
fi
IfOk=`cat /etc/netplan/50-cloud-init.yaml | grep "enp1s0:"`
if [[ $IfOk == "" ]]; then 
sed -i '/ethernets:/ r np_dhcp.conf' /etc/netplan/50-cloud-init.yaml
fi
# update network interface 
InterfaceOk=`cat /etc/netplan/50-cloud-init.yaml | grep "wlp2s0:"`

if [[ $InterfaceOk == "" ]]; then 
    sed -i '/ethernets:/ r interfaces.conf' /etc/netplan/50-cloud-init.yaml

    netplan apply
fi 

 systemctl start isc-dhcp-server 
 systemctl unmask hostapd
 systemctl enable hostapd
 systemctl start hostapd


#enable ip forward
echo 1|  tee /proc/sys/net/ipv4/ip_forward

sysctl -p

FORWARD=`sudo iptables  -t  nat  -nL |grep "192.168.124.0/24"`

if [[ $FORWARD == "" ]]; then 
#ask iptable to route
    iptables -t nat -A POSTROUTING -s 192.168.124.0/24 -o enp1s0 -j MASQUERADE

    iptables-save > /etc/iptables.rules

fi 


# build rc.local.service 
rcOK=`cat /lib/systemd/system/rc.local.service |grep "Install"`
if [[ $rcOK == "" ]]; then 

cat ./rc.local.service | while read line
        do
                val=\\$line
                echo $line | sed -i  ''/Service/i"$val"'' /lib/systemd/system/rc.local.service
        done

fi 

ln -s /lib/systemd/system/rc.local.service /etc/systemd/system/

cp S01eswarm.sh /etc/rc.local

chmod a+x /etc/rc.local
#disable network wait 
systemctl mask systemd-networkd-wait-online.service

echo "Your wireless AP is eswarm${ssid} and password is Abcd#1234"
