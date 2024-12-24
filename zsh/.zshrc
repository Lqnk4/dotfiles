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

# Force emacs keybinds
bindkey -e


# Aliases
alias sudo='sudo '
alias vim='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias top='htop'

# prompt
export PS1="%{$(tput setaf 243)%}%n%{$(tput setaf 245)%}@%{$(tput setaf 249)%}%m %{$(tput setaf 254)%}%~ %{$(tput sgr0)%}$ "
