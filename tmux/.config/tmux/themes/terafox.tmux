#!/usr/bin/env bash
# Nightfox colors for Tmux
# Style: terafox
# Upstream: https://github.com/edeneast/nightfox.nvim/raw/main/extra/terafox/terafox.tmux
set -g mode-style "fg=#0f1c1e,bg=#cbd9d8"
set -g message-style "fg=#0f1c1e,bg=#cbd9d8"
set -g message-command-style "fg=#0f1c1e,bg=#cbd9d8"
set -g pane-border-style "fg=#cbd9d8"
set -g pane-active-border-style "fg=#5a93aa"
set -g status "on"
set -g status-justify "left"
set -g status-style "fg=#cbd9d8,bg=#0f1c1e"
set -g status-left-length "100"
set -g status-left-style NONE
set -g status-left "#[fg=#0f1c1e,bg=#5a93aa,bold] #S #[fg=#5a93aa,bg=#0f1c1e,nobold,nounderscore,noitalics]"
set -g status-right ""
setw -g window-status-activity-style "underscore,fg=#587b7b,bg=#0f1c1e"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#587b7b,bg=#0f1c1e"
setw -g window-status-format "#[fg=#0f1c1e,bg=#0f1c1e,nobold,nounderscore,noitalics]#[default] [#I] #W "
setw -g window-status-current-format "#[fg=#0f1c1e,bg=#cbd9d8,bold] [#I] #W #F "
