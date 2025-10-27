# -------------------- Core Environment --------------------
$env.EDITOR = "code"
$env.VISUAL = "code"

# -------------------- Node Version Managers --------------------
# NVM (if using)
# $env.NVM_DIR = ($env.USERPROFILE | path join ".nvm")

# FNM (Fast Node Manager - recommended)
# $env.FNM_DIR = ($env.USERPROFILE | path join ".fnm")

# -------------------- Programming Language Paths --------------------
# Rust
# $env.CARGO_HOME = ($env.USERPROFILE | path join ".cargo")

# Go
# $env.GOPATH = ($env.USERPROFILE | path join "go")

# Python
# $env.PYTHONPATH = ($env.USERPROFILE | path join "python")

# -------------------- Development Tools --------------------
# Starship prompt (if using)
# mkdir ~/.cache/starship
# starship init nu | save -f ~/.cache/starship/init.nu

# Zoxide (smart cd)
zoxide init nushell | save -f ~/.zoxide.nu

# Carapace (shell completion)
# $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"

# -------------------- Secrets & API Keys --------------------
# Load from separate file for security
# if ("~/.env.nu" | path exists) {
#     source ~/.env.nu
# }

# -------------------- Windows-specific --------------------
# Set locale
$env.LANG = "en_US.UTF-8"

# -------------------- Performance --------------------
# Disable telemetry for various tools
$env.DOTNET_CLI_TELEMETRY_OPTOUT = "1"
$env.NEXT_TELEMETRY_DISABLED = "1"
$env.ASTRO_TELEMETRY_DISABLED = "1"

# -------------------- Custom Paths --------------------
# Add your custom paths here
# Example:
# $env.PATH = ($env.PATH | prepend ($env.USERPROFILE | path join "custom-tools"))
