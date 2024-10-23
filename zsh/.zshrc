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

# Prompt
export PS1="%{%F{243}%}%n%{%F{245}%}@%{%F{249}%}%m %{%F{254}%}%1~ %{%f%}$ "

# Aliases
alias sudo='sudo '
alias vim='nvim'
alias vimconfig='nvim ~/.config/nvim/'
alias bashrc='nvim ~/.bashrc'
alias riverinit='nvim ~/.config/river/init'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

