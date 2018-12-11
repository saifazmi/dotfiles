#!/usr/bin/env bash

tmux new-window -n system "gtop"
tmux split-window -h -p 50 "ranger ~"
tmux split-window -v -p 60
tmux send-keys -t 2 C-l "todo.sh list" C-m
