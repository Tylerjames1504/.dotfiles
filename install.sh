#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DOT_FOLDERS="nvim zsh"


# Check if the operating system is Ubuntu
if [[ "$(uname)" == "Linux" && -e "/etc/lsb-release" ]]; then
    # Ubuntu-specific command
    sudo apt install stow
# Check if the operating system is macOS
elif [[ "$(uname)" == "Darwin" ]]; then
    # macOS-specific command
    brew install stow
else
    # Display an error message for unsupported OS
    echo "Unsupported operating system"
    exit 1
fi

for folder in $(echo $DOT_FOLDERS | sed "s/,/ /g"); do
    echo "[+] Folder :: $folder"
    stow --ignore=README.md --ignore=LICENSE \
        -t $HOME -D $folder
    stow -v -t $HOME $folder
done

# Reload shell once installed
echo "[+] Reloading shell..."
exec $SHELL -l
