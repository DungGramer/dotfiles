# Cheatsheet — hotkeys & aliases

## Ghostty (terminal)
| Phím | Hành động |
|---|---|
| `Ctrl+V` / `Ctrl+Shift+V` / `Shift+Insert` | Paste |
| `Ctrl+Shift+N` / `Ctrl+Shift+T` | Cửa sổ mới / tab mới |
| `Ctrl+PageUp/Down`, `Ctrl+1..9` | Chuyển / nhảy tab |
| `Ctrl+=` / `Ctrl+-` / `Ctrl+0` | Phóng to / thu nhỏ / reset font |
| `Ctrl+Shift+K` | Xoá màn hình + scrollback |
| `Ctrl+Shift+Up/Down` | Nhảy giữa các lần chạy lệnh (ngoài tmux) |
| `Alt+Enter` / `F11` | Zoom split / fullscreen |
| `Ctrl+Shift+R` / `Ctrl+Shift+W` | Reload config / đóng |

## tmux (prefix = `Ctrl+b`)
| Phím | Hành động |
|---|---|
| `Ctrl+h/j/k/l` | Chuyển pane (tự nhảy split nvim) — **không cần prefix** |
| prefix + `|` / `-` | Split dọc / ngang (giữ cwd) |
| prefix + `H/J/K/L` | Resize pane |
| prefix + `z` | Zoom pane |
| prefix + `Ctrl+l` | Clear screen (vì C-l đã dùng chuyển pane) |
| prefix + `g` | lazygit popup |
| prefix + `P` | Popup shell tạm ở cwd |
| prefix + `S` | Bật/tắt sync-panes (gõ đồng thời) |
| prefix + `r` | Reload config |
| copy-mode: `v` / `y` | Chọn / copy ra clipboard |

## zsh
**Phím:** `Ctrl+←/→` nhảy từ · `Home/End/Delete` · `Ctrl+R` atuin (history) · `Ctrl+T` fzf file · `Alt+C` fzf cd · `Ctrl+X Ctrl+E` sửa lệnh trong nvim · `→`/`End` nhận autosuggestion.

**Alias chính:**
- File: `ls/ll/la/lt`, `cat`(bat), `v/vim`(nvim), `mkcd`, `...`/`....`, `reload`
- Git: `gs gco gsw gb ga gc gcm gca gd gst gf grb gp gpf gl glog`, `lg`(lazygit)
- Docker: `dc dcu dcd dcl dex dps di`
- K8s: `k kgp kgs kgd kaf kl kx kns`
