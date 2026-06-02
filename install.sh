#!/usr/bin/env bash
# ───────────────────────────────────────────────────────────────────────────
#  Bootstrap setup dev cho máy MỚI (Ubuntu/Debian).
#  Cách dùng:
#     DOTFILES_REPO=git@github.com:DungGramer/dotfiles.git ./install.sh
#  hoặc sửa biến DOTFILES_REPO bên dưới rồi chạy:  bash install.sh
# ───────────────────────────────────────────────────────────────────────────
set -euo pipefail

DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/DungGramer/dotfiles.git}"

echo "==> 1/6  Cài gói nền qua apt (cần sudo)…"
sudo apt-get update -y
sudo apt-get install -y \
    zsh git curl wget unzip build-essential \
    ca-certificates gnupg

echo "==> 2/6  Cài mise (version manager)…"
if ! command -v mise >/dev/null 2>&1; then
    curl -fsSL https://mise.run | sh
fi
export PATH="$HOME/.local/bin:$PATH"
eval "$("$HOME/.local/bin/mise" activate bash)"

echo "==> 3/6  Cài chezmoi qua mise…"
mise use -g chezmoi@latest
mise reshim 2>/dev/null || true

echo "==> 4/6  chezmoi init + apply (hỏi tên/email, ghi config, clone plugin, cài tool)…"
# --apply sẽ: clone repo -> sinh config -> apply dotfiles -> chạy run_onchange (mise install)
mise exec -- chezmoi init --apply "$DOTFILES_REPO"

echo "==> 5/6  Cài Nerd Font (Monaspace) nếu chưa có…"
if ! fc-list | grep -qi "Monaspace.*NF"; then
    mkdir -p "$HOME/.local/share/fonts"
    tmp="$(mktemp -d)"
    curl -fsSL -o "$tmp/mona.zip" \
      "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Monaspace.zip" || true
    [ -f "$tmp/mona.zip" ] && unzip -oq "$tmp/mona.zip" -d "$HOME/.local/share/fonts/Monaspace" && fc-cache -f >/dev/null
    rm -rf "$tmp"
fi

echo "==> 6/6  Đặt zsh làm shell mặc định…"
if [ "$(basename "${SHELL:-}")" != "zsh" ]; then
    chsh -s "$(command -v zsh)" || echo "  (chsh lỗi — đổi tay sau: chsh -s \$(which zsh))"
fi

cat <<'DONE'

✅ Xong! Bước cuối:
  1. Mở terminal MỚI (zsh + tất cả tool đã sẵn sàng).
  2. Chạy `nvim` lần đầu — LazyVim tự cài plugin.
  3. Chạy `atuin import auto` nếu muốn nạp history cũ.

Quản lý dotfiles từ giờ:
  chezmoi edit ~/.zshrc      # sửa
  chezmoi apply              # áp dụng
  chezmoi cd && git push     # đồng bộ lên git
DONE
