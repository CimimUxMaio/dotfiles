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


#### Check Requirements ####
if ! command -v __git_ps1 &> /dev/null; then
    if [[ -f /usr/share/git/completion/git-prompt.sh ]]; then
        show_progress "Loading /usr/share/git/completion/git-prompt.sh" . /usr/share/git/completion/git-prompt.sh
    else
        show_warning "/usr/share/git/completion/git-prompt.sh file not found, check your GIT installation files."
    fi
fi


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
curr_dir='\e[1;34m[ In\e[m\e[0;34m \w\e[m\e[1;34m ]\e[m'

# Git branch
git_branch='\e[1;32m$(__git_ps1 "(%s)" 2> /dev/null)\e[m'

# Status
status_symbol='$([[ "$?" == 1 ]] && echo "\e[1;31m*\e[m" || echo " ")'

# Prompt symbol
prompt_symbol='\e[1;35m>>=\e[m $'

# Time
prompt_time='\e[0;34m[\t]\e[m'

lhs_prompt="$curr_dir $git_branch\n$prompt_symbol "
rhs_prompt="$status_symbol $prompt_time"
prompt_fill='\e[$((COLUMNS - 11))G'
PS1="\[\e[s$prompt_fill$rhs_prompt\e[u\]$lhs_prompt"


#### QOL Options ####
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar


#### TMUX ####
## Start a new (or attach to) default tmux session
mkdir -p "$HOME/.tmux/logs/"
if [ -z "$TMUX" ]; then
    (cd "$HOME/.tmux/logs/" && tmux new -A -s default)
fi


#### ALIASES ####
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

echo -e "\e[1;32mEverything set up :)\e[m"
