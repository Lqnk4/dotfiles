set -g message-command-style "fg=#0f1c1e,bg=#cbd9d8"
set -g message-style "fg=#0f1c1e,bg=#cbd9d8"
set -g status-style "fg=#cbd9d8,bg=#0f1c1e"


set-option -g mode-style 'bg=#424856' 

set -g pane-border-style "fg=#cbd9d8"
set -g pane-active-border-style "fg=#5a93aa"

set-option -g status-justify left 
set-option -g status-left '  #{=28:session_name}  ' 
set-option -g status-left-length 32 
set-option -g status-left-style 'bold' 
set-option -g status-right '' 

set-option -g window-status-current-format ' [#I] #W ' 
set-option -g window-status-current-style 'bg=#51afef,fg=#282c34' 
set-option -g window-status-format ' [#I] #W ' 
set-option -g window-status-separator ' ' 
setw -g window-status-style "NONE,fg=#587b7b,bg=#0f1c1e"
setw -g window-status-activity-style "underscore,fg=#587b7b,bg=#0f1c1e"
