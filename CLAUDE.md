# CLAUDE.md — hướng dẫn cho Claude Code làm việc trên repo này

Repo này là **source của chezmoi**, không phải file config bình thường. Sửa sai chỗ là mất việc.
Đọc hết mục "Quy tắc sống còn" trước khi sửa bất cứ gì.

Doc cho **người dùng** (phím tắt, dev flow, cách xài tool) nằm ở `GUIDE.md`, `KEYBINDINGS.md`,
`SYSTEM-SETUP.md`. File này chỉ nói về **cách repo vận hành và cách sửa nó cho đúng**.

---

## 1. Mô hình

Một nhánh `chezmoi` cho **mọi OS** (Linux, macOS, Windows). Khác biệt xử lý bằng template +
`.chezmoiignore`, **không tách nhánh theo OS**.

```
repo (source)                    ->   $HOME (target)
dot_zshrc                        ->   ~/.zshrc
dot_config/starship.toml         ->   ~/.config/starship.toml
private_dot_ssh/private_config   ->   ~/.ssh/config          (quyền 0600)
dot_gitconfig.tmpl               ->   ~/.gitconfig           (render template)
AppData/Roaming/nushell/...      ->   %USERPROFILE%\AppData\...  (chỉ Windows)
```

Tiền tố:

| Tiền tố / đuôi | Nghĩa |
|---|---|
| `dot_` | thành dấu chấm: `dot_zshrc` → `~/.zshrc` |
| `private_` | quyền 0600 (Unix). Trên Windows gần như vô nghĩa (ACL), đừng dựa vào nó để bảo mật |
| `.tmpl` | file template, render bằng Go template |
| `run_once_` / `run_onchange_` | script trong `.chezmoiscripts/` |
| `AppData/` | không có dấu chấm nên **không** cần `dot_` |

---

## 2. Quy tắc sống còn

1. **Không bao giờ sửa thẳng file trong `$HOME`.** Lần `chezmoi apply` sau sẽ ghi đè.
   Sửa ở repo → `chezmoi apply`. Hoặc `chezmoi edit ~/.zshrc` (mở đúng file nguồn).

2. **`.chezmoiignore` match theo TARGET path, không phải source path.**
   Muốn loại `dot_zshrc` thì viết `.zshrc`, không phải `dot_zshrc`.

3. **Nó liệt kê từng file cụ thể.** Thêm file mới ở gốc repo (vd `NOTES.md`) mà quên khai
   → chezmoi apply nó thẳng vào `~/NOTES.md`. Doc/script chỉ-thuộc-repo phải khai vào đây.

4. **`chezmoi re-add` BỎ QUA file template, trong im lặng** (exit 0, không cảnh báo).
   `dot_config/mise/config.toml.tmpl` là template → `chezmoi re-add ~/.config/mise/config.toml`
   **không làm gì cả**. Thêm tool phải sửa thẳng template rồi `chezmoi apply`.
   Tương tự, `mise use -g <tool>` ghi vào *target* (`~/.config/mise/config.toml`) — file đó do
   chezmoi quản lý nên lần `apply` sau ghi đè là mất. Quy tắc chung: **nguồn là template thì
   mọi đường "bắt ngược từ $HOME" đều vô hiệu**, phải sửa nguồn.

5. **Sửa xong luôn chạy `chezmoi verify`** (exit 0 = `$HOME` khớp source). `chezmoi diff` để xem trước.

---

## 3. Việc hay làm

### Thêm/sửa một dotfile
Sửa file trong repo → `chezmoi diff` (xem trước) → `chezmoi apply` → `chezmoi verify`.

### Thêm một tool
Sửa `dot_config/mise/config.toml.tmpl` (**không** dùng `re-add`, xem quy tắc 4) → `chezmoi apply`.
Script `run_onchange_after_10-mise-install.sh.tmpl` tự chạy `mise install` vì hash của template
đổi. Hash đó `include` theo **đường dẫn source** — đổi tên file config phải sửa cả dòng hash.

Tool không có bản cho một OS → bọc `{{ if ne .chezmoi.os "windows" }}`. Để nguyên thì
`mise install` báo lỗi **mỗi lần apply**.

### Thêm thứ khác nhau theo OS
Nguyên tắc: mặc định dùng chung, **chỉ loại trừ khi tool không tồn tại** trên OS đó.
Dùng `ne "windows"` thay vì `eq "linux"` cho tool Linux+macOS, để máy macOS sau này tự nhận.

### Kiểm tra template render ra gì
```sh
chezmoi execute-template < dot_gitconfig.tmpl   # render thử
chezmoi cat ~/.gitconfig                        # kết quả cuối cùng
chezmoi managed                                 # danh sách target chezmoi quản lý
```

---

## 4. Bẫy đã trả giá — đọc trước khi sửa phần liên quan

### Template
- **`lookPath "x"` chạy lúc RENDER, không phải lúc dùng — ĐỪNG dùng nó để gác tool do mise cài.**
  Lúc render, script mise chưa chạy nên tool chưa tồn tại → lần cài đầu trên máy mới không có
  tool đó. Tệ hơn: kết quả phụ thuộc **PATH của process chạy apply**, nên apply từ shell khác
  nhau sinh file khác nhau, và apply từ chỗ thiếu tool sẽ **gỡ** cấu hình đã có ra.
  Repo từng dính đúng bẫy này với delta; nay khai thẳng `pager = delta` vì delta nằm trong mise
  config của mọi OS. Tool nào đã có trong mise config thì coi như luôn tồn tại, đừng gác.
  Nếu `chezmoi verify` báo một file lệch khó hiểu → nghi ngay `lookPath` + PATH của process.
- **`stat` thì ngược lại: dùng được, và nên dùng** cho thứ phụ thuộc *file của người dùng*
  (vd SSH key). Nó tự lành: file xuất hiện thì lần apply sau tự bật (xem `$signing`).

### Nushell (Windows)
- **`$env.HOME` KHÔNG tồn tại trên Windows** (chỉ có `USERPROFILE`). Dùng `$nu.home-path`.
- **`source` là từ khoá PARSE-TIME.** File phải tồn tại *trước khi* `config.nu` được parse, và
  không thể `source` có điều kiện. Vì vậy idiom của repo là: **sinh file init ở `env.nu`,
  `source` ở `config.nu`** (xem zoxide/carapace/mise/atuin). Thiếu file → vỡ TOÀN BỘ config.
  Nên khối sinh file luôn ghi cả nhánh `else { "" }` để file luôn tồn tại.
- **`nu -c` KHÔNG nạp `config.nu`** (chỉ REPL mới nạp). Test `config.nu` bằng `nu -c` là test giả.
  Cách kiểm: `nu -n -c 'source ~/AppData/Roaming/nushell/env.nu; source ~/AppData/Roaming/nushell/config.nu; ...'`
  Lưu ý: file nào định nghĩa `main` (như `mise activate nu`) thì khi source vào *script* sẽ bị
  nushell tự gọi `main` lúc kết thúc — gây output lạ + exit code khác 0. Đó là artifact của cách
  test, không phải lỗi config.
- **Đừng dùng `$env.LANG` để chứng minh `env.nu` đã chạy** — biến đó thường kế thừa từ process cha.
  Muốn chắc: kiểm mtime của file mà `env.nu` sinh ra (vd `~/.zoxide.nu`).
- **`mise activate` đặt PATH qua hook `pre_prompt`** → chỉ có tác dụng trong REPL. Script và lệnh
  non-interactive sẽ không thấy tool nào. Vì thế `env.nu` prepend thẳng thư mục shims.

### chezmoi trên Windows
- **Script `.sh` không tự chạy được.** Cần `[interpreters.sh]` trong config (xem `.chezmoi.toml.tmpl`).
- **Không dùng `lookPath "bash"` trên Windows**: `bash` thường trúng `C:\Windows\System32\bash.exe`
  (stub WSL), chạy trong rootfs Linux nên không hiểu đường dẫn Windows mà chezmoi truyền vào.
  Phải trỏ đích danh Git bash.

### mise
- **Không phải tool nào cũng có bản Windows**: `btop`, `jless` chỉ Linux (jless thêm macOS).
- **`eza` chỉ có backend `cargo:`** trong registry → cần Rust toolchain. Dùng `"ubi:eza-community/eza"`
  để lấy binary dựng sẵn.
- **`mise` là nơi cài tool cho MỌI OS. `system-apps.sh` KHÔNG cài tool CLI nào** — nó chỉ lo
  driver Intel, Flatpak/snap app GUI, timeshift, gnome-tweaks. `install.sh` cũng chỉ `apt install`
  zsh/git/curl/wget/unzip/build-essential. Đừng giả định "Linux có sẵn từ apt" rồi cho tool vào
  khối `eq "windows"` — repo từng dính đúng lỗi này: `starship`/`zoxide`/`fzf`/`eza`/`bat`/`fd`
  nằm trong khối Windows nên máy Linux **không có gì cài chúng**, trong khi `.zshrc` gọi thẳng.
- **Tool cài bằng mise có tên binary CHUẨN, không phải tên Debian**: `bat` (không phải `batcat`),
  `fd` (không phải `fdfind`). Debian đổi tên do trùng gói khác; đừng dùng tên đó trong config nữa.

### git
- **`core.hooksPath` THAY THẾ hoàn toàn `.git/hooks`, không cộng dồn.** Repo dùng
  `git config core.hooksPath .githooks` để bật gate gitleaks; hook nào còn nằm ở `.git/hooks`
  sẽ **im lặng ngừng chạy**. Mọi hook phải đặt trong `.githooks/`. Đã đo bằng cùng một lệnh
  push: hooksPath chưa đặt → chặn; hooksPath=.githooks + hook ở `.git/hooks` → không chặn.
- **Hook nằm trong `.githooks/` là đi lên repo public** — đừng nhúng IP/host/domain riêng vào
  đó, nếu không chính cái hook chống rò rỉ lại làm rò rỉ. Dữ liệu riêng để ở file ngoài mà
  hook đọc nếu có (xem `.personal/leak-markers.txt`).
- `~/.config/git/ignore` là đường dẫn XDG — git tự đọc kể cả khi không khai `core.excludesfile`.
- Trên Windows, `credential.helper` và `http.sslBackend` do Git for Windows đặt ở **system level**;
  `~/.gitconfig` không cần khai lại, và việc thiếu chúng ở đây **không** làm mất credential manager.

---

## 5. Riêng tư

Repo này là **public**. Không commit: token, host nội bộ, IP LAN, domain riêng, email theo dự án.

Có sẵn hai móc nối, cả hai đều **im lặng bỏ qua khi file không tồn tại** (nên người khác clone về
vẫn chạy bình thường):

| File | Móc ở đâu |
|---|---|
| `~/.config/git/config-local` | `[include]` cuối `~/.gitconfig` |
| `~/.ssh/config.local` | `Include` **đầu** `~/.ssh/config` |

`Include` của ssh đặt ở **đầu** file là cố ý: với phần lớn từ khoá, ssh lấy giá trị **bắt được đầu
tiên**, để cuối thì `Host *` phía trên đã chốt giá trị và host riêng không đè được.

Quy ước: thư mục `.personal/` đã được `.chezmoiignore` loại sẵn — muốn để thứ riêng tư đi theo
repo của bạn thì để vào đó.

> **Nếu `.personal/NOTES.md` tồn tại**: bạn đang ở bản **private gốc**, không phải bản public.
> **ĐỌC FILE ĐÓ TRƯỚC KHI PUSH BẤT CỨ GÌ** — có ràng buộc riêng về nơi được phép push.

---

## 6. Vì sao có `.gitignore`

Chỉ để `!CLAUDE.md`. Global ignore của máy chủ repo có rule `CLAUDE.md` (coi nó là config cá nhân),
mà global ignore áp cả vào repo này → `git add CLAUDE.md` sẽ **im lặng không làm gì**.
`.gitignore` cấp repo có độ ưu tiên cao hơn `core.excludesfile` nên gỡ được.
