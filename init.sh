#!/bin/bash

cp zsh/new-dist.sh run.s
sudo chmod +x run.sh

sudo ./run.sh

cp fonts/* .

sudo chmod +x ./fonts.sh

sudo ./fonts.sh

cp ./scripts/gcloud.sh .

sudo chmod +x gcloud.sh

sudo ./gcloud.sh
