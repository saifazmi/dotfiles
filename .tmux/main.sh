#!/usr/bin/env bash

tmux new-session -d -s main -n system 'gtop'
tmux split-window -h -p 50 'ranger ~'
tmux split-window -v -p 85