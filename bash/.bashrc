#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


PS1='[\u@\h \W]\$ '

# Aliases
alias sudo='sudo '
alias vim='nvim'
alias vimconfig='nvim ~/.config/nvim/'
alias bashrc='nvim ~/.bashrc'
alias riverinit='nvim ~/.config/river/init'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

