export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

[ -s "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

[ -s "$HOME/.gvm/scripts/gvm" ] && source "$HOME/.gvm/scripts/gvm"

paths=(
  "/usr/local/bin"
  "$HOME/.npm-global/bin"
  "$BUN_INSTALL/bin"
  "$HOME/.bun/bin"
  "$HOME/.platformsh/bin"
  "$HOME/.config/composer/vendor/bin"
  "$HOME/.local/bin"
)

for p in "${paths[@]}"; do
  [[ ":$PATH:" != *":$p:"* ]] && PATH="$p:$PATH"
done
export PATH

setopt NO_HUP
setopt NO_MATCH
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

alias ssh='TERM=xterm-256color ssh'

bindkey "^K" history-search-forward
bindkey "^L" history-search-backward
