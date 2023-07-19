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

# theme for fzf
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

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
alias md="ls *.md | entr -c glow README.md"
