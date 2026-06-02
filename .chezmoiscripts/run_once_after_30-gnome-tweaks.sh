#!/bin/sh
# GNOME tweaks cho dev (chỉ chạy trong session đồ hoạ, bỏ qua nếu headless).
command -v gsettings >/dev/null 2>&1 || exit 0
[ -n "$WAYLAND_DISPLAY$DISPLAY" ] || exit 0

# CapsLock -> Escape (vàng cho vim/terminal). Đổi lại: gsettings reset org.gnome.desktop.input-sources xkb-options
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']" 2>/dev/null || true

# Gõ phím lặp nhanh hơn (di chuyển trong vim mượt)
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 'uint32 25' 2>/dev/null || true
gsettings set org.gnome.desktop.peripherals.keyboard delay 'uint32 250' 2>/dev/null || true

# Touchpad: tốc độ di chuột nhanh hơn + tap-to-click
gsettings set org.gnome.desktop.peripherals.touchpad speed 0.5 2>/dev/null || true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true 2>/dev/null || true

# Âm thanh: cho phép vượt 100% (loa laptop hơi nhỏ)
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true 2>/dev/null || true

echo ">> GNOME: CapsLock=Escape, key-repeat nhanh, touchpad speed, volume>100% đã đặt."
