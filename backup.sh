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
echo "// dunst"
cp --parents .config/dunst/* dotfiles
echo "// i3wm"
cp --parents .config/i3/* dotfiles
echo "// redshift"
cp --parents .config/redshift.conf dotfiles
echo "// rofi"
cp --parents .config/rofi/* ~/dotfiles
echo "// sublime text 3"
cp --parents .config/sublime-text-3/Packages/User/*.sublime-settings dotfiles
echo "// gitconfig"
cp .gitconfig dotfiles
echo "// oh-my-zsh"
cp --parents .oh-my-zsh/themes/classyTouch.zsh-theme dotfiles
echo "// vim"
cp .vimrc dotfiles
echo "// xinit"
cp .xinitrc dotfiles
echo "// Xresources"
cp .Xresources dotfiles
cp --parents .Xresources.d/* dotfiles
echo "// zsh"
cp .zprofile dotfiles
cp .zshrc dotfiles
echo
echo "Done copying config files"
echo "git status ~/dotfiles"
echo
cd ~/dotfiles && git status
echo
echo "Please check the ~/dotfiles directory and push to Github"
