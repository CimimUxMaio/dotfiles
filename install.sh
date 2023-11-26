#!/bin/bash

## Any subsequent commands which fail will cause the shell script to exit immediately.
set -e


ask_optional() {
    stty -echo
    read -p "Install $1 configuration files? [Y/n] " -n 1 -r
    stty echo
    echo
    # True if the input is empty (default) or starts with y or Y
    if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
        return 0  # True
    else
        return 1  # False
    fi
}

install_optional() {
    if [[ $INSTALL_ALL =~ ^[Yy]$ ]] || ask_optional $1; then
        eval ${optional_configs[$1]}
    fi
}


# Install base configuration files
ln -sf ~/dotfiles/bashrc ~/.bashrc
ln -sf ~/dotfiles/bash_logout ~/.bash_logout
ln -sf ~/dotfiles/bash_profile ~/.bash_profile

# Optional configurations
declare -A optional_configs
optional_configs=(
    ["Neovim"]="ln -sf ~/dotfiles/config/nvim/ ~/.config/"
    ["Tmux"]="ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf"
    ["Alacritty"]="ln -sf ~/dotfiles/alacritty.yml ~/.alacritty.yml"
)

# Install optional configurations
for key in ${!optional_configs[@]}; do
    if [[ -z "$opt_config_keys" ]]; then
        opt_config_keys="$key"
    else
        opt_config_keys="$opt_config_keys, $key"
    fi
done

echo "The following optional configuration can be installed: $opt_config_keys"

stty -echo
read -p "Install all? [y/N] " -n 1 -r INSTALL_ALL
stty echo

for key in ${!optional_configs[@]}; do
    install_optional $key
done
