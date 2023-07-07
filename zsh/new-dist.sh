#!/bin/bash

curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh" | bash -

BREWDIR="/home/linuxbrew/.linuxbrew"
export PATH="$PATH;$BREWDIR/bin"

echo "export PATH=\"$PATH;$BREWDIR/bin\"" >> $HOME/.bashrc

brew install zsh starship zoxide fzf nvm rustup juliaup python@3.11 python@3.9 exa gh

chmod ..
