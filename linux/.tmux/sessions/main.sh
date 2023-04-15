#!/usr/bin/env bash

SESSION_NAME="main"
tmux has-session -t $SESSION_NAME &> /dev/null

if [[ $? != 0 ]]; then
    tmux new-session -d -s $SESSION_NAME
    tmux rename-window "terminal"
    source ~/.tmux/windows/system.sh
fi

tmux attach -t $SESSION_NAME