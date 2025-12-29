#!/usr/bin/env bash

pip list --outdated
pip list --outdated --format=freeze | cut -d = -f 1 | xargs -n1 sudo pip install -U
