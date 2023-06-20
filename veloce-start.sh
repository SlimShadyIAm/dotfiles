#!/bin/bash
# This is a script to quickly set up the dotfiles on a new setup.

# if git isn't installed, run the Apple command line tools installer
if ! command -v git &> /dev/null
then
    osascript -e 'display notification "Installing Xcode command line tools..."'
    xcode-select --install
fi

# Setup homebrew
osascript -e 'display notification "Installing homebrew..."'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# TODO: set up brew packages

# zsh setup
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
source zshrc
ln -s $DOTS/zshrc $HOME/.zshrc
ln -s $DOTS/zprestorc $HOME/.zprestorc

# Set up .config folder
osascript -e 'display notification "Setting up .config folder"'

mkdir -p $HOME/.config/alacritty
ln -s $DOTS/config/* $HOME/.config

# miscellaneous settings
defaults write com.apple.finder AppleShowAllFiles -boolean true; killall Finder;
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
