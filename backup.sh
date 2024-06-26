#!/usr/bin/env bash

# =============================================================================
# Dotfiles backup script
# =============================================================================

echo "---------------------------------------"
echo "Backing up: Development Environment    "
echo "---------------------------------------"

echo -e "\nBacking up ~/.zshrc ..."
rsync -av  ~/.zshrc ./commons/dev-environment/
echo -e "\nBacking up ~/.p10k.zsh ..."
rsync -av ~/.p10k.zsh ./commons/dev-environment/
echo -e "\nBacking up ~/.vimrc ..."
rsync -av  ~/.vimrc ./commons/dev-environment/
echo -e "\nBacking up ~/.gitconfig ..."
rsync -av  ~/.gitconfig ./commons/dev-environment/
echo -e "\nBacking up ~/.gitignore_global ..."
rsync -av  ~/.gitignore_global ./commons/dev-environment/
echo -e "\nBacking up ~/.config/tmux ..."
rsync -av  ~/.config/tmux/tmux.conf ./commons/dev-environment/.config/tmux/
echo -e "\nBacking up ~/.config/nvim ..."
rsync -av --delete  ~/.config/nvim/ ./commons/dev-environment/.config/nvim/

echo "---------------------------------------"
echo "Git Status"
echo "---------------------------------------"
git status
