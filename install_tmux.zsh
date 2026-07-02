#!/bin/zsh
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    os=$(awk -F= '/^ID=/{print $2}' /etc/os-release | tr -d '"')
    id_like=$(awk -F= '/^ID_LIKE=/{print $2}' /etc/os-release | tr -d '"')
    case "$os $id_like" in
        *fedora*|*rhel*)
            echo "Installing Tmux for Fedora"
            sudo dnf install tmux
            tmux -V
            ;;
        *ubuntu*|*debian*)
            echo "Installing Tmux for Ubuntu"
            sudo apt install tmux
            tmux -V
            ;;
        *)
            echo "Unsupported Linux distribution: $os"
            ;;
    esac
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "MacOS"
    brew install tmux
fi
