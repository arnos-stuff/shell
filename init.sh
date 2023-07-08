#!/bin/bash

cp zsh/new-dist.sh run.s
sudo chmod +x run.sh

sudo ./run.sh

cp fonts/* .

sudo chmod +x ./fonts.sh

sudo ./fonts.sh all

cp ./scripts/hyperjs.sh .

chmod +x hyperjs.sh

sudo ./hyperjs.sh

<<<<<<< HEAD
mkdir $HOME/.config

cp ./starship/half-pure.toml $HOME/.config/starship.toml

=======
>>>>>>> parent of 3280d1d (added init script and gcloud + fonts + starship)
cp ./scripts/gcloud.sh .

sudo chmod +x gcloud.sh

sudo ./gcloud.sh
