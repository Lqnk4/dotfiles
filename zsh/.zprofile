#
# ~/.zprofile
#

### SSH

# Start SSH Agent
SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' >"${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" >/dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" >/dev/null
    #ps ${SSH_AGENT_PID} doesn't work under Cygwin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ >/dev/null || {
        start_agent;
    }
else
    start_agent;
fi


### ENV

export EDITOR=kak
# fcitx for jp keyboard
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
#fcitx5 -d -r &
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/sbin:$PATH"
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
# Doom Emacs
export PATH="$HOME/.config/emacs/bin:$PATH"
# Anki
export ANKI_WAYLAND=1

### TMUX

### WM

# autostart wm
if [ -z "$WAYLAND_DISPLAY" ] && [ $(tty) = "/dev/tty1" ] && command -v river; then
  exec river -c $HOME/.local/bin/riverhs # remove -c flag to default to backup config
fi

