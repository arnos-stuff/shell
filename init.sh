#!/bin/bash

cp zsh/new-dist.sh run.s
sudo chmod +x run.sh

sudo ./run.sh

cp fonts/* .

sudo chmod +x ./fonts.sh

sudo ./fonts.sh

cp ./scripts/hyperjs.sh .

chmod +x hyperjs.sh

sudo ./hyperjs.sh

mkdir $HOME/.config

cp ./starship/half-pure.toml .config/starship.toml

cp ./scripts/gcloud.sh .

sudo chmod +x gcloud.sh

sudo ./gcloud.sh

