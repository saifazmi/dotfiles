# =============================================================================
# Dotfiles backup script
# =============================================================================

echo "---------------------------------------"
echo "Backing up: Development Environment    "
echo "---------------------------------------"
echo "\nSyncronising ~/.zshrc, ~/.zprofile, ~/.zshenv ..."
rsync -av ~/.zshrc ./commons/dev-environment/
rsync -av ~/.zprofile ./commons/dev-environment/
rsync -av ~/.zshenv ./commons/dev-environment/
echo "\nSyncronising ~/.config/ohmyposh/config.toml ..."
rsync -av ~/.config/ohmyposh/config.toml ./commons/dev-environment/.config/ohmyposh/
echo "\nSyncronising ~/.vimrc ..."
rsync -av ~/.vimrc ./commons/dev-environment/
echo "\nSyncronising ~/.gitconfig ..."
rsync -av ~/.gitconfig ./commons/dev-environment/
echo "\nSyncronising ~/.gitignore_global ..."
rsync -av ~/.gitignore_global ./commons/dev-environment/
echo "\nSyncronising ~/.config/tmux ..."
rsync -av ~/.config/tmux/*.conf ./commons/dev-environment/.config/tmux/
echo "\nSyncronising ~/.config/nvim ..."
rsync -av --delete ~/.config/nvim/ ./commons/dev-environment/.config/nvim/
echo "\nSyncronising ~/.config/lazygit/config.yml ..."
rsync -av --delete ~/.config/lazygit/config.yml ./commons/dev-environment/.config/lazygit/

echo "---------------------------------------"
echo "Git Status"
echo "---------------------------------------"
git status
