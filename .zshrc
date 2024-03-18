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
export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#191724,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8,separator:#403d52
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

launch() {
	if [[ -z $TMUX ]]; then
		"$HOME/.config/tmux/tmux_launch.sh"
	else
		tmux popup -EE -w 60% -h 60% "$HOME/.config/tmux/tmux_launch.sh"
  fi
}

export d="$HOME/Git"
export DOTS="$HOME/dotfiles"
alias search="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' | xargs nvim"

alias nano=nvim
alias vim=nvim
alias cd=z
alias ls=lsd
alias md='fd -e md | fzf --bind "enter:execute(entr -c glow {} <<< {})"'
alias cat=bat

export PATH="/usr/local/opt/openjdk@17/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="$PATH:$HOME/flutter/bin"
export FLUTTER_ROOT="/Users/shady/flutter"

eval "$(zoxide init zsh)"
eval $(thefuck --alias)

function flutter-watch(){
  # tmux new-session \;\
  tmux send-keys 'flutter run --pid-file=/tmp/tf1.pid' Enter \;\
  split-window -h \;\
  send-keys 'npx -y nodemon -e dart -x "cat /tmp/tf1.pid | xargs kill -s USR1"' Enter \;\
  resize-pane -y 5 -t 1 \;\
  select-pane -t 0 \;
}

