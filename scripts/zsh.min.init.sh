#!/bin/bash

# starship

curl -fsSL https://starship.rs/install.sh | bash


# zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# fzf

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

mkdir .config

# micro

curl https://getmic.ro | bash
