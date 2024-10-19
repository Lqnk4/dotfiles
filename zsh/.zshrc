# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1024
SAVEHIST=1024
setopt extendedglob nomatch notify
unsetopt autocd beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '${HOME}/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

prompt="[%n@%m %1~]%$ "

# Aliases
alias sudo='sudo '
alias vim='nvim'
alias vimconfig='nvim ~/.config/nvim/'
alias bashrc='nvim ~/.bashrc'
alias riverinit='nvim ~/.config/river/init'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

