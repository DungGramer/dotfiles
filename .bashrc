# Launch Zsh
if [ -t 1 ]; then
  exec zsh
fi

# ----------------------
# Git Command Aliases
# ----------------------

function gitcl { git clone "$1" && cd "$(basename "$1" .git)" && code .; }

alias n="npm"
alias ns='npm start'
alias nr='npm run'
alias nu='npm uninstall'
alias ng='npm i -g'
alias nid='npm i -D'

alias ys='yarn start'
alias yr='yarn run'
