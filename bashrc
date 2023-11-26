#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


#### History File ####
# History file location
HISTFILE="$HOME/.cache/bash/bash_history"

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Set history length
HISTSIZE=100
HISTFILESIZE=200


#### Appearance ####
# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Get GIT prompt
git_prompt() {
    prompt=""
    if command -v __git_ps1 &> /dev/null; then
        prompt="$(__git_ps1 '(%s)')"
    else
        echo "WARNING: Command __git_ps1 not found."
    fi
    echo "$prompt"
}

# Set custom prompt
PS1='In \w $(git_prompt)\n>>= '


#### QOL Options ####
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar


#### TMUX ####
## Start a new (or attach to) default tmux session
if [ -z "$TMUX" ]; then
    tmux new -A -s default
fi


#### ALIASES ####
alias ls='ls --color=auto'
alias ll="ls -l"
alias ..="cd .."
alias vim="nvim"
alias grep='grep --color=auto'
alias py="python3"


#### Run Custom System Configuration ####
if [[ -f ~/.custom_bash ]]; then
    . ~/.custom_bash
fi
