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

brew tap homebrew/cask
brew tap homebrew/cask-fonts
brew tap homebrew/cask-versions

brew install bat tmux node nvm neovim ripgrep fzf fd lazygit pfetch mackup gnu-sed
brew install --cask alacritty alt-tab discord-canary dozer font-jetbrains-mono-nerd-font nordvpn qbittorrent rar rectangle vlc 1password arc calibre cloudflare-warp craft dozer figma gitkraken microsoft-edge muzzle notion raycast shottr slack spotify the-unarchiver visual-studio-code whatsapp


# zsh setup
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
source zshrc
ln -s $DOTS/zshrc $HOME/.zshrc
ln -s $DOTS/zprestorc $HOME/.zprestorc
ln -s $DOTS/mackup.cfg ~/.mackup.cfg
mackup restore

# Set up .config folder
osascript -e 'display notification "Setting up .config folder"'

ln -s $DOTS/config/* $HOME/.config

# miscellaneous settings
defaults write com.apple.finder AppleShowAllFiles -boolean true; killall Finder;
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
