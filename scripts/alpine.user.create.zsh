#!/bin/bash

# user setup
LUSER=shae

groupadd -r $LUSER -g 777
useradd -m -u 777 -r -g 777 -s /bin/zsh $LUSER
adduser $LUSER sudo
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
