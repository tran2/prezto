#!/bin/zsh
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [ $(awk -F= '/^NAME/{print $2}' /etc/os-release)="Ubuntu" ]; then
        echo "Installing Tmux for Ubuntu"
        sudo apt install tmux
        tmux -V
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "MacOS"
    brew install tmux
fi
