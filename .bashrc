# Launch Zsh
if [ -t 1 ]; then
  exec zsh
fi

# ----------------------
# Git Command Aliases
# ----------------------

function gitcl { git clone "$1" && cd "$(basename "$1" .git)" && code .; }
function clean_branch { git fetch -p && for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do git branch -D $branch; done }
function del_node_modules { find . -name "node_modules" -type d -prune -print | xargs du -chs; }
function del_prev_branch { git branch -D @{-1}; }


# Aliases
## Change Directory
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"

## NPM
alias n="npm"
alias ns='npm start'
alias nr='npm run'
alias nrb='npm run build'
alias nu='npm uninstall'
alias nug='npm uninstall -g'
alias nup='npm prune'
alias ni='npm i'
alias nig='npm i -g'
alias nid='npm i -D'
alias nio='npm i -O'

alias npk='npx npkill'

## Yarn
alias y='yarn'
alias yi='yarn install'
alias ya='yarn add'
alias yad='yarn add -D'
alias yag='yarn global add'
alias yr='yarn remove'
alias yrg='yarn global remove'
alias yl='yarn link'
alias ylu='yarn unlink'
alias ys='yarn start'
alias yw='yarn workspace'
alias ywi='yarn workspaces info'
alias ycc='yarn cache clean'

## PNPM
alias pn='pnpm'
alias px='pnpm dlx'
alias pex='pnpm exec'
alias pi='pnpm i'
alias pa='pnpm add'
alias pad='pnpm add -D'
alias pag='pnpm add -g'
alias pr='pnpm remove'
alias prg='pnpm remove -g'
alias pf='pnpm -r --filter'

## Image Optimizer
alias iow="npx @squoosh/cli --webp auto " # +file-name
alias ioa="npx @squoosh/cli --avif auto " # +file-name
alias iop="npx @squoosh/cli --oxipng auto " # +file-name
