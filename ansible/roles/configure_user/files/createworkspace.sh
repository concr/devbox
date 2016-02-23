#!/bin/bash

function createworkspace {
  WORKSPACEPATH="$HOME/workspace/$1/$2/htdocs/"
  IP=$(/sbin/ifconfig eth1 | awk -F ' *|:' '/inet addr/{print $4}')
  NEWHOST="$2.$1.$(hostname -f)"
  mkdir -p "$WORKSPACEPATH"
  echo ""
  echo "$WORKSPACEPATH created"
  echo ""
  echo "Please add following line to your local /etc/hosts file:"
  echo ""
  echo "$IP $NEWHOST"
  echo ""
}

if [ -z "$1" ]; then
  read -p "Enter Type for new workspace [website|project|somethingelse]: " TYPE;
else
  TYPE=$1
fi

if [ -z "$2" ]; then
  read -p "Enter Name for new workspace [name]: " NAME;
else
  NAME=$2
fi

createworkspace $TYPE $NAME
