#!/bin/bash

## Any subsequent commands which fail will cause the shell script to exit immediately.
set -e


# Links

ln -sf ~/dotfiles/bashrc ~/.bashrc
ln -sf ~/dotfiles/bash_logout ~/.bash_logout
ln -sf ~/dotfiles/bash_profile ~/.bash_profile
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/config/nvim/ ~/.config/
