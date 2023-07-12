#!/bin/bash

curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh" | bash -

BREWDIR="/home/linuxbrew/.linuxbrew"
export PATH="$PATH:$BREWDIR/bin"

echo "export PATH=\"$PATH:$BREWDIR/bin\"" >> $HOME/.bashrc

brew install starship zoxide fzf nvm exa gh fd 
