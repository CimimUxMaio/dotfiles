#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


#### Check Requirements ####
if [[ -f /usr/share/git/completion/git-prompt.sh ]]; then
    echo -n "Loading /usr/share/git/completion/git-prompt.sh ... "
    . /usr/share/git/completion/git-prompt.sh
    echo "Done!"
else
    echo "WARNING: /usr/share/git/completion/git-prompt.sh file not found, check your GIT installation files."
fi

# Check if command was succesfully created
if ! command -v __git_ps1 &> /dev/null; then
    echo "WARNING: Command __git_ps1 not found."
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
HISTSIZE=100
HISTFILESIZE=200


#### Appearance ####
# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Set custom prompt
# In <current directory path> <git branch?>\n>>=
PS1='[In \w] $(__git_ps1 "(%s)" 2> /dev/null)\n>>= $ '


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

echo "All set up :)"
