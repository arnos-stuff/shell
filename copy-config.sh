#!/bin/bash

mkdir $HOME/.config

# Check if the argument is supplied
if [ -z "$1" ]; then
    echo "No argument supplied"
    exit 1
fi

# Define source and target files
zshrc_source="./zsh/zshrc.$1.zsh"
zshrc_target="$HOME/.zshrc"

zshenv_source="./zsh/zshenv.$1.zsh"
zshenv_base="./zsh/zshenv.base.zsh"
zshenv_target="$HOME/.zshenv"

# Copy .zshrc
if [ -f "$zshrc_source" ]; then
    cp "$zshrc_source" "$zshrc_target"
    echo "Copied $zshrc_source to $zshrc_target"
else
    echo "Source file $zshrc_source does not exist"
fi

# Copy .zshenv
if [ -f "$zshenv_source" ]; then
    cp "$zshenv_source" "$zshenv_target"
    echo "Copied $zshenv_source to $zshenv_target"
else
    if [ -f "$zshenv_base" ]; then
        cp "$zshenv_base" "$zshenv_target"
        echo "Copied $zshenv_base to $zshenv_target"
    else
        echo "Neither $zshenv_source nor $zshenv_base exist"
    fi
fi

cp ./prompts/g-g-go.toml $HOME/.config/starship.toml
