# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Custom aliases
alias ls="ls --color=auto"
alias ll="ls -l"

## If fd and fzf are available, create a custom alias
if command -v fd &> /dev/null && command -v fzf &> /dev/null; then
    alias ff='cd $(fd --type d | fzf --tmux center,70%)'
fi

## If eza is available, replace ls with it
if command -v eza &> /dev/null; then
    alias ls="eza"
fi
#
## If nvim is available, replace vim with it
if command -v nvim &> /dev/null; then
    alias vim="nvim"
fi
# End of custom aliases

# Custom prompt
## After each command check window size and update
setopt PROMPT_SUBST

## Evaluate length of string with ANSI escape codes
function evaluated_len() {
    print -P "$1" | sed 's/\x1b\[[0-9;]*m//g' | wc -m
}

## Compute prompt before each command
function precmd() {
    ## Status
    error_code=$?
    prompt_status=" "
    if [ $error_code -ne 0 ]; then
        prompt_status='%B%F{red}*%f%b'
    fi

    ## Current directory
    prompt_cwd='%F{blue}%B[ In %b%~ %B]%b%f'

    ## Host
    prompt_host='%B%F{green}(%m)%f%b'

    ## Symbol
    prompt_symbol='%F{magenta}>>=%f $'

    ## Time
    prompt_time='%F{blue}[%*]%f'

    ## Compute padding size
    prompt_status_time="${prompt_status} ${prompt_time}"
    prompt_padding_size=$(( $COLUMNS - $(evaluated_len $prompt_cwd) - $(evaluated_len $prompt_status_time) ))
    prompt_padding=$(printf "%*s" $prompt_padding_size "")

    ## Combine all
    prompt_row_1="${prompt_cwd}${prompt_padding}${prompt_status_time}"
    prompt_row_2="${prompt_host} ${prompt_symbol}"
    PROMPT="${prompt_row_1}"$'\n'"${prompt_row_2} "
}
# End of custom prompt

# Update PATH to include user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
# End of PATH update
#
