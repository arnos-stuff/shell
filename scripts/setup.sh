#!/bin/bash

DEFAULT=../zsh/shae-ubuntu-zsh


if [ -z "$1-zshrc" ]
then
    echo "No argument supplied, using default: $DEFAULT"
    ZSHRC="${DEFAULT}rc"
    ZSHENV="${DEFAULT}env"
else
    ZSHRC="$1-zshrc"
    ZSHENV="$1-zshenv"
fi


if [ -f "$ZSHRC" ]
then
    echo "Sourcing $ZSHRC"
    source "$ZSHRC"
    cp "$ZSHRC" ~/.zshrc
    cp "$ZSHENV" ~/.zshenv
else
    echo "No zshrc found at $ZSHRC"
fi

mkdir ~/.config/
cp -r ../apps/micro ~/.config/