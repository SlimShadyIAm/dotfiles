# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export PNPM_HOME="/Users/shady/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm

# source a file that contains some secrets
source ~/.zshrc-secrets

launch() {
	if [[ -z $TMUX ]]; then
		"$HOME/.config/tmux/tmux_launch.sh"
	else
		tmux popup -EE -w 60% -h 60% "$HOME/.config/tmux/tmux_launch.sh"
  fi
}

alias nano=nvim
alias vim=nvim
export d="$HOME/Git"
export DOTS="$HOME/.config/dotfiles"
