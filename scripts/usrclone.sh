#!/bin/bash

if [ "$#" -lt 2 ];then
	echo "Usage: $0 [src-user] [dest-user]";
	exit 1;
fi

SRC=$1
DEST=$2




SRC_GROUPS=$(id -Gn ${SRC} | sed "s/ /,/g" | sed -r 's/\<'${SRC}'\>\b,?//g')
SRC_SHELL=$(awk -F : -v name=${SRC} '(name == $1) { print $7 }' /etc/passwd)

sudo useradd --groups ${SRC_GROUPS} --shell ${SRC_SHELL} --create-home ${DEST}
sudo passwd ${DEST}
