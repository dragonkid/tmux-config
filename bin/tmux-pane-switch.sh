#!/bin/bash

# customizable
LIST_DATA=" #{session_name} #{window_name}"
FZF_COMMAND="fzf-tmux -p --delimiter=: --with-nth 3 --color=hl:2"

# do not change
TARGET_SPEC="#{session_name}:#{window_id}:"

# select pane
LINE=$(tmux list-panes -a -F "$TARGET_SPEC $LIST_DATA" | sort -u | $FZF_COMMAND) || exit 0
# split the result
args=(${LINE//:/ })
# activate session/window/pane
tmux select-pane -t ${args[2]} && tmux select-window -t ${args[1]} && tmux switch-client -t ${args[0]}
