#!/usr/bin/env bash
# ───────────────────────────────────────────────────────────────────────────
#  Setup hệ thống Ubuntu cho dev — ThinkPad E14 Gen 7 (Intel Arrow Lake).
#  Chạy:  bash ~/.local/share/chezmoi/system-apps.sh
#  An toàn chạy lại nhiều lần (idempotent).
# ───────────────────────────────────────────────────────────────────────────
set -euo pipefail
echo "Cần quyền sudo cho phần cài đặt hệ thống…"; sudo -v

# ── 1. APT: GPU/video accel + tiện ích + build deps ────────────────────────
echo "==> [1/6] APT: tăng tốc GPU/video, tiện ích, thư viện build"
sudo add-apt-repository -y multiverse >/dev/null 2>&1 || true   # cho intel-media-va-driver-non-free
# PPA đồ hoạ chính thức của Intel — driver VA-API MỚI cho Core Ultra/Arrow Lake
# (bản trong repo Ubuntu là 24.1.0, quá cũ cho ARL -> iHD init failed).
sudo add-apt-repository -y ppa:kobuk-team/intel-graphics >/dev/null 2>&1 || true
sudo apt-get update -y
sudo apt-get install -y \
    intel-media-va-driver-non-free vainfo mesa-va-drivers \
    mesa-vulkan-drivers vulkan-tools \
    timeshift \
    gnome-tweaks gnome-shell-extension-manager \
    flameshot vlc \
    intel-gpu-tools \
    pkg-config libssl-dev zlib1g-dev libffi-dev libbz2-dev libreadline-dev libsqlite3-dev
# Nâng stack VA-API Intel lên bản PPA (đồng bộ iHD driver + libva + GMM cho Arrow Lake)
sudo apt-get install -y --only-upgrade \
    intel-media-va-driver-non-free libva2 libva-drm2 libva-wayland2 libva-x11-2 libigdgmm12 || true

# ── 2. Flatpak: Flathub + Teams + OBS + DBeaver ────────────────────────────
echo "==> [2/6] Flatpak: Flathub + Teams + OBS + DBeaver"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y --noninteractive flathub \
    com.github.IsmaelMartinez.teams_for_linux \
    com.obsproject.Studio \
    io.dbeaver.DBeaverCommunity

# ── 3. Snap: Postman ───────────────────────────────────────────────────────
echo "==> [3/6] Snap: Postman"
sudo snap install postman || true

# ── 4. Firmware: kiểm tra & cập nhật ───────────────────────────────────────
echo "==> [4/6] Firmware (fwupd)"
sudo fwupdmgr refresh --force >/dev/null 2>&1 || true
sudo fwupdmgr get-updates || echo "  (không có firmware update)"

# ── 5. inotify watchers (bắt buộc cho web/JS dev project lớn) ──────────────
echo "==> [5/6] inotify watchers"
sudo tee /etc/sysctl.d/99-dev.conf >/dev/null <<'EOF'
fs.inotify.max_user_watches=524288
fs.inotify.max_user_instances=512
EOF
sudo sysctl --system >/dev/null 2>&1 || true

# ── 6. Kiểm tra hardware video decode ──────────────────────────────────────
echo "==> [6/6] Kiểm tra VA-API (hardware video decode)"
vainfo 2>&1 | grep -iE "Driver version|VAProfileH264|VAProfileHEVCMain|init failed" | head -5 || echo "  (vainfo: kiểm tra lại sau khi đăng nhập lại)"

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
