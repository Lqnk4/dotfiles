# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1024
SAVEHIST=1024
setopt extendedglob nomatch notify
unsetopt autocd beep
#bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '${HOME}/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# vi mode
bindkey -v
export KEYTIMEOUT=1
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char

# env
export PATH="$HOME/.local/bin:$PATH"

# Aliases
alias sudo='sudo '
alias vim='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# starship prompt
eval "$(starship init zsh)"
