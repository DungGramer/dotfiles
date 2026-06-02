#!/usr/bin/env bash
# ───────────────────────────────────────────────────────────────────────────
#  Setup hệ thống Ubuntu cho dev — ThinkPad E14 Gen 7 (Intel Arrow Lake).
#  Chạy:  bash ~/.local/share/chezmoi/system-apps.sh
#  An toàn chạy lại nhiều lần (idempotent).
# ───────────────────────────────────────────────────────────────────────────
set -euo pipefail
echo "Cần quyền sudo cho phần cài đặt hệ thống…"; sudo -v

# ── 1. APT: GPU/video accel + tiện ích + build deps ────────────────────────
echo "==> [1/5] APT: tăng tốc GPU/video, tiện ích, thư viện build"
sudo add-apt-repository -y multiverse >/dev/null 2>&1 || true   # cho intel-media-va-driver-non-free
sudo apt-get update -y
sudo apt-get install -y \
    intel-media-va-driver-non-free vainfo mesa-va-drivers \
    mesa-vulkan-drivers vulkan-tools \
    timeshift \
    gnome-tweaks gnome-shell-extension-manager \
    flameshot vlc \
    pkg-config libssl-dev zlib1g-dev libffi-dev libbz2-dev libreadline-dev libsqlite3-dev

# ── 2. Flatpak: Flathub + Teams (community) + OBS ──────────────────────────
echo "==> [2/5] Flatpak: Flathub + Teams + OBS"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y --noninteractive flathub \
    com.github.IsmaelMartinez.teams_for_linux \
    com.obsproject.Studio

# ── 3. Snap: DBeaver + Postman ─────────────────────────────────────────────
echo "==> [3/5] Snap: DBeaver + Postman"
sudo snap install dbeaver-ce || true
sudo snap install postman || true

# ── 4. Firmware: kiểm tra & cập nhật ───────────────────────────────────────
echo "==> [4/5] Firmware (fwupd)"
sudo fwupdmgr refresh --force >/dev/null 2>&1 || true
sudo fwupdmgr get-updates || echo "  (không có firmware update)"

# ── 5. Kiểm tra hardware video decode ──────────────────────────────────────
echo "==> [5/5] Kiểm tra VA-API (hardware video decode)"
vainfo 2>/dev/null | grep -iE "Driver version|VAProfileH264|VAProfileHEVCMain" | head -4 || echo "  (vainfo: kiểm tra lại sau khi đăng nhập lại)"

cat <<'DONE'

✅ Xong setup hệ thống. Việc cần làm sau:
  1. ĐĂNG XUẤT / ĐĂNG NHẬP LẠI (để GNOME nạp extension, snap/flatpak vào menu).
  2. Timeshift: mở "Timeshift" -> chọn RSYNC -> chọn ổ đích -> tạo snapshot đầu tiên
     (hoặc CLI: sudo timeshift --create --comments "baseline").
  3. Bật tăng tốc video trong trình duyệt:
       - Chrome:  chrome://flags -> bật "Hardware-accelerated video decode" (VaapiVideoDecoder)
       - Firefox: about:config -> media.ffmpeg.vaapi.enabled = true
  4. GNOME: mở "Extension Manager" -> Browse, gợi ý: Caffeine, Clipboard Indicator, Vitals, Tactile/Forge (tiling).
  5. Teams: chạy "Teams for Linux"; OBS Wayland dùng portal (chọn nguồn khi capture).
DONE
