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

## Copy this into your .zshrc file
export COLOR_RESET=$'\x1b[0m'
export COLOR_LACK=$'\x1b[38;2;112;128;144m'
export COLOR_LUSTER=$'\x1b[38;2;222;238;237m'
export COLOR_ORANGE=$'\x1b[38;2;255;170;136m'
export COLOR_GREEN=$'\x1b[38;2;120;153;120m'
export COLOR_BLUE=$'\x1b[38;2;119;136;170m'
export COLOR_RED=$'\x1b[38;2;215;0;0m'
export COLOR_BLACK=$'\x1b[38;2;0;0;0m'
export COLOR_GRAY1=$'\x1b[38;2;8;8;8m'
export COLOR_GRAY2=$'\x1b[38;2;25;25;25m'
export COLOR_GRAY3=$'\x1b[38;2;42;42;42m'
export COLOR_GRAY4=$'\x1b[38;2;68;68;68m'
export COLOR_GRAY5=$'\x1b[38;2;85;85;85m'
export COLOR_GRAY6=$'\x1b[38;2;122;122;122m'
export COLOR_GRAY7=$'\x1b[38;2;170;170;170m'
export COLOR_GRAY8=$'\x1b[38;2;204;204;204m'
export COLOR_GRAY9=$'\x1b[38;2;221;221;221m'

# You can use these colors in your scripts...
# echo "${COLOR_BLUE}Some message${COLOR_RESET}"

# Aliases
alias sudo='sudo '
alias vim='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# starship prompt
eval "$(starship init zsh)"
