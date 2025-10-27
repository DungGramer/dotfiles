# -------------------- Core Settings --------------------
$env.config = {
    show_banner: false

    # Completion settings
    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "fuzzy"
    }

    # History settings
    history: {
        max_size: 100_000
        sync_on_enter: true
        file_format: "sqlite"
    }

    # Keybindings
    keybindings: [
        {
            name: completion_menu
            modifier: none
            keycode: tab
            mode: [emacs vi_normal vi_insert]
            event: {
                until: [
                    { send: menu name: completion_menu }
                    { send: menunext }
                    { edit: complete }
                ]
            }
        }
        {
            name: history_menu
            modifier: control
            keycode: char_r
            mode: [emacs, vi_insert, vi_normal]
            event: { send: menu name: history_menu }
        }
        {
            name: clear_screen
            modifier: control
            keycode: char_l
            mode: [emacs, vi_insert, vi_normal]
            event: { send: clearscrollback }
        }
    ]

    # Prompt
    use_ansi_coloring: true
    edit_mode: emacs

    # Performance
    buffer_editor: "code"
}

# -------------------- Custom Prompt --------------------
# Fast, informative prompt with git status
def create_left_prompt [] {
    let home = $nu.home-path
    let cwd  = $env.PWD

    let path_segment = if ($cwd | str starts-with $home) {
        $cwd | str replace $home "~"
    } else {
        $cwd
    }

    let git_branch = (
        do -i { git branch --show-current } | complete | get stdout | str trim
    )

    let git_status = if ($git_branch | is-not-empty) {
        let changes = (do -i { git status --porcelain } | complete | get stdout | str trim)
        let status_icon = if ($changes | is-empty) { "✓" } else { "●" }
        $" (ansi yellow)[(ansi reset)($git_branch)(ansi yellow)] (ansi red)($status_icon)(ansi reset)"
    } else { "" }

    $"(ansi cyan)($path_segment)(ansi reset)($git_status) "
}

$env.PROMPT_COMMAND = { create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""
$env.PROMPT_INDICATOR = { "❯ " }
$env.PROMPT_INDICATOR_VI_INSERT = { ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = { "〉" }
$env.PROMPT_MULTILINE_INDICATOR = { "::: " }

# -------------------- PATH Configuration --------------------
$env.PATH = (
    $env.PATH
    | split row (char esep)
    | prepend ($env.USERPROFILE | path join "bin")
    | prepend ($env.USERPROFILE | path join ".local" "bin")
    | prepend ($env.USERPROFILE | path join "AppData" "Local" "Programs" "Microsoft VS Code" "bin")
    | uniq
)

# -------------------- Aliases: Navigation --------------------
alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..
alias ..... = cd ../../../..
alias ~ = cd ~
alias - = cd -

# -------------------- Aliases: Git --------------------
alias g = git
alias gs = git status -sb
alias ga = git add
alias gaa = git add .
alias gc = git commit -m
alias gca = git commit --amend
alias gcane = git commit --amend --no-edit
alias gp = git push
alias gpf = git push --force-with-lease
alias gpl = git pull
alias gplr = git pull --rebase
alias gf = git fetch
alias gfa = git fetch --all
alias gb = git branch
alias gba = git branch -a
alias gco = git checkout
alias gcb = git checkout -b
alias gcm = git checkout (do -i { git branch -a | lines | find main | first } | default "master" | str trim | str replace "* " "" | str replace "remotes/origin/" "")
alias gm = git merge
alias gms = git merge --squash
alias gl = git log --oneline --graph --decorate -20
alias gla = git log --oneline --graph --decorate --all -20
alias gd = git diff
alias gds = git diff --staged
alias gr = git restore
alias grs = git restore --staged
alias gst = git stash
alias gstp = git stash pop
alias gstl = git stash list
alias grb = git rebase
alias grbi = git rebase -i
alias grbc = git rebase --continue
alias grba = git rebase --abort

# -------------------- Aliases: Node/NPM --------------------
alias n = npm
alias ni = npm install
alias nis = npm install --save
alias nid = npm install --save-dev
alias nig = npm install -g
alias nu = npm uninstall
alias nug = npm uninstall -g
alias nr = npm run
alias ns = npm start
alias nd = npm run dev
alias nb = npm run build
alias nt = npm test
alias nl = npm list --depth=0
alias nod = npm outdated
alias nup = npm update
alias nci = npm ci
alias nx = npx
alias nkill = npx npkill

# -------------------- Aliases: PNPM --------------------
alias p = pnpm
alias pi = pnpm install
alias pif = pnpm install --frozen-lockfile
alias pa = pnpm add
alias pad = pnpm add -D
alias pag = pnpm add -g
alias pr = pnpm remove
alias prg = pnpm remove -g
alias pn = pnpm run
alias ps = pnpm start
alias pd = pnpm dev
alias pb = pnpm build
alias pt = pnpm test
alias px = pnpm dlx
alias pex = pnpm exec
alias pf = pnpm -r --filter
alias pw = pnpm --workspace
alias pup = pnpm update
alias pout = pnpm outdated
alias pl = pnpm list --depth=0

# -------------------- Aliases: Bun --------------------
alias b = bun
alias bi = bun install
alias ba = bun add
alias bad = bun add -d
alias bag = bun add -g
alias brm = bun remove
alias bn = bun run
alias bs = bun start
alias bd = bun dev
alias bb = bun build
alias bt = bun test
alias bx = bunx

# -------------------- Aliases: Yarn --------------------
alias y = yarn
alias yi = yarn install
alias ya = yarn add
alias yad = yarn add -D
alias yag = yarn global add
alias yr = yarn remove
alias ys = yarn start
alias yd = yarn dev
alias yb = yarn build
alias yw = yarn workspace

# -------------------- Aliases: Docker --------------------
alias d = docker
alias dc = docker compose
alias dcu = docker compose up -d
alias dcd = docker compose down
alias dcl = docker compose logs -f
alias dcb = docker compose build
alias dcr = docker compose restart
alias dps = docker ps
alias dpsa = docker ps -a
alias di = docker images
alias drm = docker rm -f
alias drmi = docker rmi
alias dprune = docker system prune -af

# -------------------- Aliases: VSCode --------------------
alias c = code .
alias co = code

# -------------------- Aliases: File Operations --------------------
alias ll = ls -la
alias la = ls -a
alias l = ls
alias cls = clear

# -------------------- Custom Commands --------------------

# Git clone and open in VSCode
def gitcl [url: string] {
    let repo_name = ($url | path basename | str replace ".git" "")
    git clone $url
    cd $repo_name
    code .
}

# Clean merged/gone branches
def clean_branch [] {
    git fetch -p
    let gone_branches = (
        git branch -vv
        | lines
        | find ": gone]"
        | each { |line| $line | str trim | split row " " | first }
    )

    if ($gone_branches | is-empty) {
        print "No branches to clean"
    } else {
        print $"Deleting ($gone_branches | length) branches:"
        $gone_branches | each { |branch|
            print $"  - ($branch)"
            git branch -D $branch
        }
    }
}

# Quick commit and push
def qc [...message: string] {
    git add .
    git commit -m ($message | str join " ")
    git push
}

# Conventional commit
def gcom [type: string, ...message: string] {
    git commit -m $"($type): ($message | str join ' ')"
}

# Find and count node_modules
def find_nm [] {
    ls **/**/node_modules
    | where type == dir
    | each { |it|
        {
            path: $it.name,
            size: (du $it.name | get apparent | first)
        }
    }
    | sort-by size --reverse
}

# Clean all node_modules
def clean_nm [] {
    let modules = (ls **/**/node_modules | where type == dir)
    let count = ($modules | length)

    if $count == 0 {
        print "No node_modules found"
        return
    }

    print $"Found ($count) node_modules directories"
    let confirm = (input "Delete all? (y/N): ")

    if $confirm == "y" or $confirm == "Y" {
        $modules | each { |it| rm -rf $it.name }
        print "Deleted all node_modules"
    }
}

# Create directory and cd
def mkcd [name: string] {
    mkdir $name
    cd $name
}

# Get my IP
def myip [] {
    http get https://api.ipify.org
}

# Kill process on port
def killport [port: int] {
    let pids = (
        netstat -ano
        | lines
        | find $":($port)"
        | each { |line| $line | split row " " | last }
        | uniq
    )

    if ($pids | is-empty) {
        print $"No process on port ($port)"
    } else {
        $pids | each { |pid| taskkill /F /PID $pid }
    }
}

# Extract archives
def extract [file: string] {
    match ($file | path parse | get extension) {
        "zip" => { unzip $file },
        "tar" => { tar -xf $file },
        "gz" => { tar -xzf $file },
        "7z" => { 7z x $file },
        _ => { print "Unknown archive format" }
    }
}

# Package manager detection and install
def pkg [command: string, ...args: string] {
    if (which pnpm | is-not-empty) {
        pnpm $command ...$args
    } else if (which bun | is-not-empty) {
        bun $command ...$args
    } else if (which yarn | is-not-empty) {
        yarn $command ...$args
    } else {
        npm $command ...$args
    }
}

# Enhanced ls with git status
def lsg [] {
    let git_status = (
        do -i { git status --porcelain }
        | complete
        | get stdout
        | lines
        | each { |line|
            {
                status: ($line | str substring 0..2 | str trim),
                file: ($line | str substring 3.. | str trim)
            }
        }
    )

    ls | each { |it|
        let status = (
            $git_status
            | where file == $it.name
            | get status
            | first
            | default ""
        )

        $it | insert git_status $status
    }
}

# Disk usage with sorting
def ducks [] {
    du *
    | sort-by apparent --reverse
    | first 10
}

# Project info
def proj [] {
    let pkg = (
        if ("package.json" | path exists) {
            open package.json
        } else {
            {}
        }
    )

    print $"📦 Project: (ansi cyan)($pkg.name? | default 'N/A')(ansi reset)"
    print $"📝 Version: (ansi yellow)($pkg.version? | default 'N/A')(ansi reset)"
    print $"🔧 Engine: (ansi green)($pkg.engines?.node? | default 'N/A')(ansi reset)"

    if ("package-lock.json" | path exists) {
        print "📋 Manager: npm"
    } else if ("pnpm-lock.yaml" | path exists) {
        print "📋 Manager: pnpm"
    } else if ("bun.lockb" | path exists) {
        print "📋 Manager: bun"
    } else if ("yarn.lock" | path exists) {
        print "📋 Manager: yarn"
    }

    let git_branch = (do -i { git branch --show-current } | complete | get stdout | str trim)
    if ($git_branch | is-not-empty) {
        print $"🌿 Branch: (ansi magenta)($git_branch)(ansi reset)"
    }
}

# -------------------- Completions --------------------
# Add custom completions
$env.config.completions.external = {
    enable: true
    max_results: 100
    completer: null
}

# -------------------- Environment Variables --------------------
# Add your custom environment variables here
# $env.EDITOR = "code"
# $env.VISUAL = "code"

# -------------------- Starship Prompt Integration --------------------
# Ensure starship is installed and set up autoload
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# Zoxide (smart cd)
source ~/.zoxide.nu

# Carapace (shell completion)
source $"($nu.cache-dir)/carapace.nu"
