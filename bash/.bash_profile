#
# ~/.bash_profile
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

### EXPORTS

# fcitx for jp keyboard
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
#fcitx5 -d -r &

# Fix for IntelliJ windows (dated)
export _JAVA_AWT_WM_NONREPARENTING=1

### BASHRC

[[ -f ~/.bashrc ]] && . ~/.bashrc

### WM

# autostart wm
if [ -z "$WAYLAND_DISPLAY" ] && [ $(tty) = "/dev/tty1" ]; then
  exec river
fi
