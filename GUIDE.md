# 📘 Cẩm nang sử dụng máy dev (từ A–Z)

> Dành cho người mới: đọc **mục 0** trước (5 phút), rồi tra cứu các mục sau khi cần.
> Xem đẹp nhất trên GitHub, hoặc trong terminal: `bat ~/.local/share/chezmoi/GUIDE.md`

## Mục lục
0. [Bắt đầu nhanh — 5 phút](#0)
1. [Ghostty (terminal)](#1)
2. [tmux (chia cửa sổ + lưu phiên)](#2)
3. [zsh (gõ lệnh thông minh)](#3)
4. [Tìm kiếm & điều hướng](#4)
5. [Neovim / LazyVim (code editor)](#5)
6. [Git + lazygit](#6)
7. [Docker & Kubernetes](#7)
8. [Bộ công cụ dòng lệnh](#8)
9. [Quản lý cấu hình (chezmoi + mise)](#9)
10. [Phím & thiết bị hệ thống](#10)
11. [⭐ DEV FLOW — quy trình hằng ngày](#11)
12. [Cheatsheet 1 trang](#12)
13. [Gặp sự cố?](#13)

---

<a id="0"></a>
## 0. Bắt đầu nhanh — 5 phút

Bạn chỉ cần nhớ **5 điều** này là dùng được ngay:

1. **Mở terminal** → tự có zsh + prompt đẹp (starship). Gõ lệnh như bình thường.
2. **Gõ vài chữ rồi bấm `↑`** → lọc lại các lệnh cũ đã gõ (lịch sử thông minh). `Ctrl+R` để tìm lịch sử kiểu fuzzy.
3. **`z tên-thư-mục`** → nhảy tới thư mục hay dùng (không cần gõ full path). VD: `z dotfiles`.
4. **`v`** = mở Neovim. Trong Neovim **bấm phím `Space` rồi chờ 1 giây** → hiện menu tất cả lệnh. Đây là cách học mọi thứ.
5. **`lg`** = mở lazygit (giao diện git trực quan). `k9s` = giao diện Kubernetes.

Quy ước trong tài liệu: `Ctrl+S` = giữ Ctrl bấm S. `prefix` (trong tmux) = `Ctrl+b`. `<leader>` (trong Neovim) = phím `Space`.

---

<a id="1"></a>
## 1. Ghostty (terminal)

Cửa sổ dòng lệnh. Phím tắt:

| Phím | Làm gì |
|---|---|
| `Ctrl+V` | Dán (paste) |
| `Ctrl+Shift+C` / bôi đen | Copy |
| `Ctrl+Shift+T` | Tab mới · `Ctrl+1..9` nhảy tab · `Ctrl+PageUp/Down` chuyển tab |
| `Ctrl+Shift+N` | Cửa sổ mới |
| `Ctrl+=` / `Ctrl+-` / `Ctrl+0` | Phóng to / thu nhỏ / reset cỡ chữ |
| `Ctrl+Shift+K` | Xoá sạch màn hình |
| `Ctrl+Shift+↑/↓` | Nhảy lên/xuống giữa các lần chạy lệnh trước |
| `F11` | Toàn màn hình |
| `Ctrl+Shift+R` | Nạp lại cấu hình Ghostty |

> Thực tế bạn sẽ dùng **tmux** để chia màn hình (mục 2) thay vì tab của Ghostty.

---

<a id="2"></a>
## 2. tmux — chia cửa sổ + lưu phiên

**tmux là gì:** chia 1 terminal thành nhiều ô (pane), nhiều cửa sổ (window), và **tự lưu lại khi tắt máy** — bật lại đúng như cũ.

**Mở:** gõ `tmux` (lần đầu) hoặc nó tự khôi phục phiên cũ.

Mọi phím tmux bắt đầu bằng **prefix = `Ctrl+b`** (bấm rồi thả, sau đó bấm phím lệnh). Riêng di chuyển pane thì KHÔNG cần prefix.

| Phím | Làm gì |
|---|---|
| `Ctrl+h/j/k/l` | **Di chuyển giữa các ô** (trái/xuống/lên/phải) — không cần prefix, liền mạch cả với Neovim |
| `prefix` rồi `\|` | Chia ô **dọc** (trái-phải) |
| `prefix` rồi `-` | Chia ô **ngang** (trên-dưới) |
| `prefix` rồi `H/J/K/L` | Phóng to/thu nhỏ ô (giữ Shift) |
| `prefix` rồi `z` | Phóng to 1 ô ra full (bấm lại để thu) |
| `prefix` rồi `c` | Cửa sổ mới · `prefix` `1..9` chuyển cửa sổ · `prefix` `,` đổi tên |
| `prefix` rồi `Ctrl+l` | Xoá màn hình (clear) |
| `prefix` rồi `g` | Mở **lazygit** toàn màn hình |
| `prefix` rồi `P` | Mở 1 shell popup tạm (bấm `Ctrl+d`/`exit` để đóng) |
| `prefix` rồi `[` | Vào chế độ cuộn/copy: di bằng phím, `v` chọn, `y` copy, `q` thoát |
| `prefix` rồi `d` | **Detach** — rời tmux nhưng phiên vẫn chạy ngầm |
| `prefix` rồi `s` | Danh sách phiên · `prefix` `F` tìm phiên/cửa sổ kiểu fuzzy |

> Phiên tự lưu mỗi 15 phút và tự khôi phục khi mở lại (kể cả sau reboot). Không lo mất việc đang dở.

---

<a id="3"></a>
## 3. zsh — gõ lệnh thông minh

Shell có sẵn gợi ý, tô màu, hoàn thành thông minh.

**Khi đang gõ:**
| Phím | Làm gì |
|---|---|
| `Tab` | Hoàn thành lệnh/đường dẫn — hiện menu fuzzy, gõ tiếp để lọc |
| `↑` / `↓` | Gõ vài chữ trước rồi bấm → lọc lịch sử **khớp** với chữ đó |
| `Ctrl+R` | Tìm lịch sử lệnh kiểu fuzzy (atuin) — gõ bất kỳ chữ nào trong lệnh cũ |
| `Ctrl+T` | Chọn **file** bằng fuzzy (chèn vào lệnh đang gõ) |
| `Alt+C` | Nhảy vào **thư mục** bằng fuzzy |
| `→` (mũi tên phải) | Chấp nhận gợi ý xám (autosuggestion) |
| `Ctrl+←` / `Ctrl+→` | Nhảy theo từ |
| `Ctrl+X` `Ctrl+E` | Mở lệnh đang gõ trong Neovim để sửa (lệnh dài) |

**Alias (lệnh tắt) — gõ ít, làm nhiều:**
| Tắt | = | Tắt | = |
|---|---|---|---|
| `ls` `ll` `la` `lt` | liệt kê file (eza, có icon) | `cat` | xem file màu mè (bat) |
| `v` / `vim` | nvim | `mkcd x` | tạo thư mục `x` + vào luôn |
| `..` `...` `....` | lùi 1/2/3 cấp thư mục | `reload` | nạp lại zsh |

Git/Docker/K8s alias xem mục 6 và 7.

---

<a id="4"></a>
## 4. Tìm kiếm & điều hướng (cốt lõi, dùng mỗi ngày)

| Lệnh | Làm gì | Ví dụ |
|---|---|---|
| `z <tên>` | Nhảy tới thư mục hay dùng (zoxide) | `z dot` → ~/.local/share/chezmoi |
| `zi` | Chọn thư mục kiểu fuzzy | |
| `fzf` | Bộ lọc fuzzy vạn năng (gắn vào `Ctrl+T`, `Alt+C`, `Ctrl+R`) | |
| `rg <chữ>` | Tìm **nội dung** trong code (ripgrep, siêu nhanh) | `rg "TODO"` |
| `fd <tên>` | Tìm **file theo tên** | `fd config` |
| `eza --tree` / `lt` | Xem cây thư mục | |
| `bat <file>` | Xem file (màu + số dòng) | `bat package.json` |
| `yazi` | Trình quản lý file dạng cây (preview ảnh/code), `q` để thoát | |

> Mẹo: `rg` + `fzf` = tìm rồi mở. Trong Neovim đã tích hợp sẵn (mục 5).

---

<a id="5"></a>
## 5. Neovim / LazyVim — code editor

Mở: `v` hoặc `nvim`. Lần đầu hơi lạ vì là editor kiểu **modal** (có chế độ).

### Quy tắc sống còn
- **3 chế độ:** `Normal` (mặc định, để di chuyển/ra lệnh) · `Insert` (gõ chữ — bấm `i`) · `Visual` (bôi chọn — bấm `v`).
- **Về Normal:** bấm `Esc` (hoặc CapsLock — bạn đã map CapsLock=Esc).
- **⭐ Học mọi thứ:** ở Normal, bấm **`Space`** rồi **chờ 1 giây** → hiện menu (which-key) tất cả lệnh. Cứ bấm theo menu.
- **Lưu/thoát:** `:w` lưu · `:q` thoát · `:wq` lưu+thoát · `:q!` thoát không lưu. (`<leader>qq` thoát hẳn.)

### Phím hay dùng (`<leader>` = `Space`)
| Phím | Làm gì |
|---|---|
| `<leader>ff` | Tìm & mở file (fuzzy) |
| `<leader>fg` hoặc `<leader>sg` | Tìm **nội dung** trong cả project |
| `<leader>e` | Bật/tắt cây thư mục (file explorer) |
| `<leader>,` | Chuyển nhanh giữa các file đang mở (buffer) |
| `Shift+h` / `Shift+l` | File trước / file sau |
| `<leader>gg` | Mở **lazygit** ngay trong nvim |
| `gd` | Nhảy tới định nghĩa hàm/biến · `gr` xem nơi dùng · `K` xem mô tả |
| `<leader>ca` | Code action (sửa lỗi tự động, import…) |
| `<leader>cr` | Đổi tên biến (cả project) |
| `<leader>cf` | Format code (prettier/eslint…) |
| `]d` / `[d` | Lỗi tiếp theo / trước đó |
| `Ctrl+h/j/k/l` | Chuyển giữa các ô (liền mạch với tmux) |
| `<leader>H` / `<leader>h` | Harpoon: ghim file / mở menu file đã ghim |
| `<leader>l` | Quản lý plugin (Lazy) · `:Mason` quản lý LSP/formatter |

> LSP (gợi ý code, báo lỗi, auto-import) tự bật theo ngôn ngữ. Lần đầu mở file `.ts`/`.py`/`.go`… Mason sẽ tự cài bộ hỗ trợ — chờ chút.

---

<a id="6"></a>
## 6. Git + lazygit

**lazygit (`lg`)** — giao diện trực quan, **nên dùng cho 90% thao tác git**:
- Mở: `lg` (terminal) hoặc `prefix+g` (tmux) hoặc `<leader>gg` (nvim).
- Trong lazygit: `Space` stage file · `c` commit · `P` push · `p` pull · dùng `Tab`/mũi tên di chuyển · `?` xem trợ giúp · `q` thoát.

**Alias dòng lệnh (khi cần nhanh):**
| Tắt | Lệnh | Tắt | Lệnh |
|---|---|---|---|
| `gs` | git status | `gd` | git diff (đẹp, side-by-side) |
| `ga` | git add | `gco` | git checkout |
| `gcm "msg"` | git commit -m | `gsw` | git switch |
| `gp` / `gl` | push / pull | `gst` | git stash |
| `glog` | log dạng cây | `gpf` | push --force-with-lease (an toàn) |

**Tự động (không cần làm gì):** mọi commit được **ký số → có badge "Verified"** trên GitHub. `git diff`/`git log` hiển thị đẹp nhờ **delta**. `push` tự tạo nhánh trên remote.

---

<a id="7"></a>
## 7. Docker & Kubernetes

**Docker:**
| Tắt | Lệnh |
|---|---|
| `lzd` | **lazydocker** — giao diện TUI quản lý container/image/log (nên dùng) |
| `dps` / `di` | docker ps / images |
| `dcu` / `dcd` / `dcl` | compose up -d / down / logs -f |
| `dex <ct> bash` | vào shell trong container |

**Kubernetes:**
| Tắt | Lệnh |
|---|---|
| `k9s` | **Giao diện TUI quản lý cluster** (must-have): xem pod/log/exec, `:` để gõ tài nguyên (vd `:pods`), `?` trợ giúp, `Ctrl+c` thoát |
| `kctx` | Đổi **cluster/context** (chống nhầm môi trường) |
| `kns` | Đổi **namespace** |
| `k` | kubectl · `kgp` get pods · `kl` logs -f · `kx <pod> -- bash` exec |
| `stern <pod>` | Xem log nhiều pod cùng lúc |

> Prompt (starship) hiện sẵn **context + namespace k8s** đang dùng → luôn biết mình đang ở cluster nào.

---

<a id="8"></a>
## 8. Bộ công cụ dòng lệnh

| Lệnh | Làm gì |
|---|---|
| `tldr <lệnh>` | Tóm tắt cách dùng 1 lệnh kèm ví dụ (VD `tldr tar`) — quên cú pháp thì hỏi nó |
| `btop` | Theo dõi CPU/RAM/nhiệt độ (đẹp), `q` thoát |
| `dust` | Xem thư mục nào nặng (thay `du`) |
| `duf` | Dung lượng ổ đĩa (thay `df`) |
| `jless <file.json>` | Xem JSON gấp/mở từng nhánh, `q` thoát |
| `jq` / `yq` | Xử lý JSON / YAML (VD `cat a.json \| jq '.name'`) |
| `gh` | GitHub trong terminal: `gh pr list`, `gh pr create`, `gh repo view --web` |
| `gh auth login` | **Cần chạy 1 lần** để dùng `gh` và tính năng Octo trong nvim |

---

<a id="9"></a>
## 9. Quản lý cấu hình (chezmoi + mise)

Toàn bộ cấu hình của bạn được quản lý tập trung → sửa 1 chỗ, đồng bộ mọi máy.

**Sửa một file cấu hình** (vd .zshrc, .tmux.conf):
```bash
chezmoi edit ~/.zshrc      # mở file nguồn để sửa
chezmoi apply              # áp dụng thay đổi vào máy
```
> ⚠️ ĐỪNG sửa thẳng `~/.zshrc` — lần `chezmoi apply` sau sẽ ghi đè. Luôn sửa qua `chezmoi edit`.

**Đồng bộ lên GitHub:**
```bash
chezmoi cd                 # vào thư mục cấu hình (là 1 git repo)
git add -A && git commit -m "..." && git push
exit                       # rời ra
```

**Cài thêm công cụ** (qua mise, không cần sudo):
```bash
mise use -g <tên>          # vd: mise use -g ripgrep
chezmoi re-add ~/.config/mise/config.toml   # lưu vào cấu hình
```

**Dựng máy mới** (5 năm sau / máy khác):
```bash
sh -c "$(curl -fsSL https://mise.run)"          # cài mise
mise use -g chezmoi
chezmoi init --apply git@github.com:DungGramer/dotfiles.git --branch chezmoi
bash ~/.local/share/chezmoi/system-apps.sh      # app + driver hệ thống
```

---

<a id="10"></a>
## 10. Phím & thiết bị hệ thống

- **CapsLock = Esc** (tiện cho Neovim). Đổi lại: `gsettings reset org.gnome.desktop.input-sources xkb-options`.
- **Tiếng Việt:** fcitx5 + Bamboo. Bật/tắt gõ tiếng Việt: **`Ctrl+Space`**. (Nếu app nào chưa gõ được → đăng nhập lại 1 lần.)
- **Tốc độ chuột:** touchpad/trackpoint chỉnh bằng `gsettings ...peripherals.touchpad speed` / `...mouse speed` (dải -1..1).
- **Âm lượng >100%** đã bật; loa nhỏ có thể cài thêm EasyEffects (`flatpak install flathub com.github.wwmm.easyeffects`).
- **Cuộn touchpad** quá nhanh: chỉnh trong Firefox `about:config` → `mousewheel.default.delta_multiplier_y`.

Chi tiết driver/app hệ thống: xem `SYSTEM-SETUP.md` và `system-apps.sh` trong repo.

---

<a id="11"></a>
## 11. ⭐ DEV FLOW — quy trình một ngày làm việc

**Bắt đầu ngày:**
1. Mở Ghostty → tmux tự khôi phục phiên hôm qua (đúng layout, đúng thư mục).
2. `z <project>` để nhảy vào dự án. (Hoặc `prefix+P` mở popup chọn nhanh.)
3. `lg` xem trạng thái git, hoặc `gl` để pull mới nhất.

**Code:**
4. Chia màn hình: `prefix+|` (1 bên code, 1 bên chạy lệnh).
5. `v .` mở Neovim. `<leader>ff` tìm file, `<leader>fg` tìm nội dung.
6. Sửa code: `gd` nhảy định nghĩa, `<leader>ca` sửa lỗi, `<leader>cr` đổi tên, lưu `:w` (tự format).
7. Chạy/test ở ô bên cạnh (`Ctrl+l` sang ô phải). Lỗi watcher? đã tăng inotify rồi.

**Commit & push:**
8. `<leader>gg` (trong nvim) hoặc `lg`: stage (`Space`) → commit (`c`) → push (`P`). Commit tự ký Verified.
9. Tạo PR: `gh pr create` hoặc xem trên web `gh repo view --web`.

**Hạ tầng (nếu làm k8s/docker):**
10. `kctx` chọn đúng cluster → `k9s` xem pod/log. `lzd` xem container.

**Hết ngày:** cứ đóng máy — tmux tự lưu, mai mở lại y nguyên. Có thay đổi cấu hình thì `chezmoi cd && git push`.

---

<a id="12"></a>
## 12. Cheatsheet 1 trang (in ra dán bàn)

```
TERMINAL   Ctrl+V dán · Ctrl+Shift+T tab · Ctrl+= /- /0 cỡ chữ
TMUX(^b)   ^h/j/k/l đổi ô · ^b | hoặc - chia ô · ^b z phóng · ^b d thoát ngầm
           ^b g lazygit · ^b [ cuộn(q thoát) · ^b c cửa sổ mới
ZSH        Tab hoàn thành · ↑ lọc lịch sử · ^R tìm lịch sử · ^T file · Alt+C thư mục
           z <dir> nhảy thư mục · → nhận gợi ý
NVIM       i gõ · Esc về · Space=menu · :w lưu · :q thoát
           <Spc>ff file · <Spc>fg tìm chữ · <Spc>e cây · <Spc>gg git · gd định nghĩa
GIT        lg lazygit · gs trạng thái · gcm "msg" · gp push · gl pull
K8S/DOCK   k9s · kctx cluster · kns namespace · lzd docker
TRA CỨU    tldr <lệnh>   |   TIẾNG VIỆT  Ctrl+Space
CẤU HÌNH   chezmoi edit ~/.zshrc → chezmoi apply → chezmoi cd && git push
```

---

<a id="13"></a>
## 13. Gặp sự cố?

| Triệu chứng | Cách xử |
|---|---|
| Quên phím trong Neovim | Bấm `Space` chờ menu, hoặc `<leader>sk` tìm phím |
| Quên cú pháp 1 lệnh | `tldr <lệnh>` |
| Sửa config xong không thấy đổi | Chưa `chezmoi apply`, hoặc mở terminal mới |
| nvim báo thiếu LSP | `:Mason` cài, `:LazyHealth` kiểm tra |
| tmux rối/treo | `prefix` `r` (reload) hoặc `tmux kill-server` rồi mở lại |
| Gõ tiếng Việt không được ở 1 app | Đăng nhập lại (env fcitx mới) |
| Lỡ tay hỏng config | `chezmoi cd && git log` → `git revert`/`git checkout` bản cũ |

> Tài liệu khác trong repo: `README.md` (tổng quan), `KEYBINDINGS.md` (phím tắt gọn), `SYSTEM-SETUP.md` (hệ thống).
