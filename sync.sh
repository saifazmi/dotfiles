# =============================================================================
# Dotfiles backup script
# =============================================================================

echo "---------------------------------------"
echo "Backing up: Development Environment    "
echo "---------------------------------------"
echo "\nSyncronising ~/.zshrc ..."
rsync -av  ~/.zshrc ./commons/dev-environment/
echo "\nSyncronising ~/.p10k.zsh ..."
rsync -av ~/.p10k.zsh ./commons/dev-environment/
echo "\nSyncronising ~/.vimrc ..."
rsync -av  ~/.vimrc ./commons/dev-environment/
echo "\nSyncronising ~/.gitconfig ..."
rsync -av  ~/.gitconfig ./commons/dev-environment/
echo "\nSyncronising ~/.config/tmux ..."
rsync -av  ~/.config/tmux/tmux.conf ./commons/dev-environment/.config/tmux/
echo "\nSyncronising ~/.config/nvim ..."
rsync -av  ~/.config/nvim/ ./commons/dev-environment/.config/nvim/

