#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

# Aliases
alias sudo='sudo '
alias vim='nvim'
alias bashrc='nvim ~/.bashrc'
alias swayconfig='nvim ~/.config/sway/config'
alias ls='ls --color=auto'
alias vimconfig='nvim ~/.config/nvim/'
