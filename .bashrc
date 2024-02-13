#
# ~/.bashrc
#

show_progress() {
    echo -n -e "\e[1m$1 ...\e[m "
    ${@:2}
    echo -e "\e[0;32mDone!\e[m"
}

show_warning() {
    echo -e "\e[1;33mWARNING:\e[m $1"
}

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


#### History File ####
# History file location
mkdir -p "$HOME/.cache/bash/"
HISTFILE="$HOME/.cache/bash/bash_history"

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Set history length
HISTSIZE=1000
HISTFILESIZE=2000


#### Appearance ####
# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

## Set custom prompt
# Current directory
curr_dir='\[\e[1;34m\][ In \[\e[0;34m\]\w \[\e[1;34m\]]'

# Git branch
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# Show only if non-empty
git_branch='\[\e[1;32m\]$([[ -z $(parse_git_branch) ]] || echo "($(parse_git_branch))")'

# Status
status_symbol='$([[ "$?" == 1 ]] && echo "\[\e[1;31m\]*" || echo " ")'

# Prompt symbol
prompt_symbol='\[\e[1;35m\]>>=\[\e[m\] $ '

# Time
prompt_time='\[\e[0;34m\][\t]'

# Padding to right align status and time
prompt_fill='\e[$((COLUMNS - 11))G'

PS1="$curr_dir $git_branch$prompt_fill$status_symbol $prompt_time\n$prompt_symbol"


#### QOL Options ####
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar


#### ALIASES ####
alias ls="ls --color=auto"

# If eza is available, replace ls with it
if command -v eza &> /dev/null; then
    alias ls="eza"
fi

# Utils
alias ll="ls -l"
alias ..="cd .."
alias vim="nvim"
alias py="python3"
alias bashrc="source $HOME/.bashrc"


#### Run Custom System Configuration ####
if [[ -f ~/.custom_bash ]]; then
    show_progress "Loading ~/.custom_bash" . ~/.custom_bash
fi

clear
