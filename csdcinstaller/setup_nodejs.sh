#!/bin/bash
## install nodejs

echo -e "setting up nodejs"

curl_exist=`whereis curl | awk -F ":"  '{print $2}'`
if [[ $curl_exist == "" ]]; then 
	apt -y install curl
fi
node_exist=1
node_test=`whereis node | awk -F ":"  '{print $2}'`
if [[ $node_test == "" ]]; then 
   node_exist=0
else 
  version_test=$(node -v |grep v10)
  echo -e " node versoin : $version"
  if [[ $version_test == "" ]];then
    node_exist=0
  fi 
fi
echo -e "is node exist: $node_exist"
if [[ $node_exist -eq 0 ]]
then
  echo " ok "
  curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
  apt-get install -y nodejs
else 
  echo " node escaped"
fi

