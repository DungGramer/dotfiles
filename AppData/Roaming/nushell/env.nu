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

# $nu.home-path, không phải $env.HOME: Windows không đặt HOME (chỉ có USERPROFILE),
# nên $env.HOME làm env.nu chết ngay lúc khởi động với lỗi 'cannot find column HOME'.
# Đây là nơi mise đặt binary, phải có trên PATH trước khi gọi tool bên dưới.
$env.PATH = (
    $env.PATH
    | split row (char esep)
    | prepend ($nu.home-path | path join ".local/bin")
    | uniq
)

# -------------------- Development Tools --------------------
# Starship prompt (if using)
# mkdir ~/.cache/starship
# starship init nu | save -f ~/.cache/starship/init.nu

# LUẬT CHUNG cho mọi khối sinh file init bên dưới:
# config.nu `source` những file này, mà `source` là từ khoá parse-time -> thiếu file là vỡ
# TOÀN BỘ config, không phải chỉ mất một tool. Tệ hơn: lệnh ngoài mà lỗi thì env.nu DỪNG
# ngay tại đó, các khối phía dưới không chạy, kéo theo vỡ dây chuyền.
# Nên: luôn `which` trước, và luôn ghi file (rỗng nếu thiếu tool) để file luôn tồn tại.

# Zoxide (smart cd)
if (which zoxide | is-not-empty) { zoxide init nushell } else { "" } | save -f ~/.zoxide.nu

# Carapace (shell completion)
# $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir $"($nu.cache-dir)"
if (which carapace | is-not-empty) { carapace _carapace nushell } else { "" } | save --force $"($nu.cache-dir)/carapace.nu"

# mise (version manager) — đối xứng với `mise activate zsh` trong .zshrc.
#
# Shim lên PATH ở đây, KHÔNG chỉ dựa vào `mise activate`: activate đặt PATH bằng
# hook pre_prompt, tức chỉ có tác dụng trong REPL — script và lệnh non-interactive
# sẽ không thấy tool nào. Shim thì hoạt động ở mọi ngữ cảnh (mise tự resolve version
# lúc gọi). `mise activate` vẫn được source bên config.nu để lo phần đổi version
# theo thư mục và biến env trong REPL.
$env.PATH = (
    $env.PATH
    | split row (char esep)
    | prepend ($env.LOCALAPPDATA | path join "mise" "shims")
    | uniq
)

# Sinh file init ở env.nu rồi `source` bên config.nu, giống hệt zoxide ở trên:
# env.nu chạy trước lúc config.nu được parse, mà `source` là từ khoá parse-time
# nên file bắt buộc phải tồn tại từ trước.
# Luôn ghi file (rỗng khi thiếu tool) để `source` không làm vỡ config máy mới.
if (which mise | is-not-empty) { mise activate nu } else { "" } | save -f ~/.mise.nu

# atuin (lịch sử thông minh, Ctrl-R) — đối xứng với .zshrc.
# --disable-up-arrow: giữ Up = history thường, khớp .zshrc.
if (which atuin | is-not-empty) { atuin init nu --disable-up-arrow } else { "" } | save -f ~/.atuin.nu

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
