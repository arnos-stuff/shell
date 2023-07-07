#!/bin/bash

curl -LO "https://releases.hyper.is/download/deb"

mv "deb" "hyper.deb"

sudo dpkg -i hyper.deb
