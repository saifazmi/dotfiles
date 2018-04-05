#!/bin/sh

# Author    : Saif Azmi <hi@saifazmi.com>
# Created   : 13/12/2017
# Updated   : 13/12/2017
# Purpose   : A dotfile backup script with a bunch of `cp` commands

if which colordiff &> /dev/null; then
    diff=colordiff
else
    diff=diff
fi

echo "Backing up dotfiles"
echo "==================="
echo
echo "Copying config files..."
cd $HOME
echo "==== Window Manager ===="
echo "// i3wm"
cp --parents .config/i3/* dotfiles
cp --parents /usr/lib/i3blocks/battery dotfiles
echo "// rofi"
cp --parents .config/rofi/* dotfiles
echo "// dunst"
cp --parents .config/dunst/* dotfiles
echo "// redshift"
cp --parents .config/redshift.conf dotfiles

echo "==== Dev Tools ===="
echo "// sublime text 3"
cp --parents .config/sublime-text-3/Packages/User/*.sublime-settings dotfiles
echo "// vs code"
cp --parents .config/Code/CachedExtensions/user dotfiles
cp --parents .config/Code/User/settings.json dotfiles
echo "// vim"
cp .vimrc dotfiles
echo "// gitconfig"
cp .gitconfig dotfiles

echo "==== Terminal ===="
echo "// zsh"
cp .zprofile dotfiles
cp .zshrc dotfiles
echo "// oh-my-zsh"
cp --parents .oh-my-zsh/themes/classyTouch.zsh-theme dotfiles
echo "// tmux"
cp .tmux.conf dotfiles
cp --parents .tmux/* dotfiles

echo "==== Xorg ===="
echo "// xinit"
cp .xinitrc dotfiles
echo "// Xresources"
cp .Xresources dotfiles
cp --parents .Xresources.d/* dotfiles
echo
echo "Done copying config files"
echo "git status ~/dotfiles"
echo
cd ~/dotfiles && git status
echo
echo "Please check the ~/dotfiles directory and push to Github"
