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

brew tap homebrew/cask-fonts
brew tap homebrew/cask-versions
brew tap oven-sh/bun
brew tap FelixKratz/formulae

brew install bat tmux node nvm neovim ripgrep fzf fd lazygit pfetch stow gnu-sed prettierd exa zoxide borders entr
brew install --no-quarantine --cask nikitabobko/tap/aerospace
brew install --cask wezterm discord-canary dozer font-jetbrains-mono-nerd-font rar rectangle vlc 1password arc cloudflare-warp dozer figma gitkraken muzzle notion raycast shottr slack spotify the-unarchiver visual-studio-code whatsapp microsoft-outlook

brew services start felixkratz/formulae/borders

# zsh setup
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
touch ~/.zshrc-secrets

stow .
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
mkdir ~/Git
mkdir ~/Git/work
mkdir ~/Git/personal

# miscellaneous settings
defaults write com.apple.finder AppleShowAllFiles -boolean true; killall Finder;
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write -g NSWindowShouldDragOnGesture YES
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
