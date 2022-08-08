# Launch Zsh
if [ -t 1 ]; then
  exec zsh
fi

# ----------------------
# Git Command Aliases
# ----------------------

function gitcl { git clone "$1" && cd "$(basename "$1" .git)" && code .; }
function clean_branch { git fetch -p && for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do git branch -D $branch; done }

alias n="npm"
alias ns='npm start'
alias nr='npm run'
alias nu='npm uninstall'
alias ng='npm i -g'
alias nid='npm i -D'

alias ys='yarn start'
alias yr='yarn run'
