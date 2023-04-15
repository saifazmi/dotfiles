#!/usr/bin/env bash

tmux new-window -n network 'vpn'
tmux split-window -h -p 50 'sudo nethogs'
tmux split-window -v -p 50 'sudo iftop'
