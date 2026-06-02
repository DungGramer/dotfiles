# System setup (cần sudo — chạy 1 lần mỗi máy)

chezmoi/mise không cần root, nhưng 2 mục dưới là cấp hệ thống. Copy-paste chạy 1 lần.

## 1. Tăng inotify watchers (gần như bắt buộc cho web/JS dev)
Project lớn (webpack/vite/next…) hay báo `ENOSPC: System limit for number of file watchers reached` nếu không tăng.

```bash
sudo tee /etc/sysctl.d/99-dev.conf >/dev/null <<'EOF'
fs.inotify.max_user_watches=524288
fs.inotify.max_user_instances=512
EOF
sudo sysctl --system
```

## 2. Tăng giới hạn file mở (nofile)
Dev server / nhiều container có thể chạm trần mặc định (1024).

```bash
sudo tee /etc/security/limits.d/99-nofile.conf >/dev/null <<'EOF'
*  soft  nofile  65536
*  hard  nofile  65536
EOF
# (đăng xuất/đăng nhập lại để có hiệu lực; kiểm tra: ulimit -n)
```

## Tham khảo — đã tự động (không cần làm tay)
- CapsLock → Escape + key-repeat nhanh: đặt qua `gsettings` (script `run_once_after_30-gnome-tweaks.sh`).
- Đổi lại CapsLock: `gsettings reset org.gnome.desktop.input-sources xkb-options`
