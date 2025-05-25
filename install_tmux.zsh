#!/bin/zsh
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    os=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
    if [ os="Ubuntu" ] || [ os="Linux Mint" ]; then
        echo "Installing Tmux for Ubuntu"
        sudo apt install tmux
        tmux -V
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "MacOS"
    brew install tmux
fi
