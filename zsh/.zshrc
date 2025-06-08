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
autoload -Uz add-zsh-hook
compinit
# End of lines added by compinstall

# Spawn new terminal instances in the current working directory (ctrl+shift+n)
function osc7-pwd() {
    emulate -L zsh # also sets localoptions for us
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}

function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
}
add-zsh-hook -Uz chpwd chpwd-osc7-pwd

# Force emacs keybinds
bindkey -e

# Aliases
alias sudo='sudo '
# alias vim='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias top='htop'

# prompt

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
# This line obtains information from the vcs.
zstyle ':vcs_info:git*' formats " ∈ %F{default}%b%F{default} "
precmd() {
    vcs_info
}
setopt PROMPT_SUBST

PROMPT="%F{default}%~%F{default}\${vcs_info_msg_0_}"$'\n'"%F{default}λx:%(?.⊤.⊥)%F{default} " 

