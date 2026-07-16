# Dotfiles (chezmoi)

Setup dev cá nhân — quản lý bằng [chezmoi](https://chezmoi.io), tool cài bằng [mise](https://mise.jdx.dev).

Một nhánh duy nhất cho mọi máy: Linux, macOS, Windows. Khác biệt giữa các OS xử lý bằng
template + `.chezmoiignore`, không tách nhánh. Không có danh tính cá nhân nào nhúng sẵn —
`chezmoi init` sẽ hỏi tên/email/khoá ký, nên bạn clone về là ra config của chính bạn.

## Thành phần

| Lĩnh vực | Công cụ | Linux/macOS | Windows |
|---|---|:---:|:---:|
| Terminal | Ghostty | ✅ | ✗ (chưa có bản Windows) |
| Multiplexer | tmux | ✅ | ✗ |
| Shell | zsh + plugins / nushell | zsh | nushell |
| Prompt | starship | ✅ | ✅ |
| History | atuin (Ctrl-R) | ✅ | ✅ |
| Editor | Neovim + LazyVim | ✅ | ✅ |
| Git | delta, alias, ký commit bằng SSH | ✅ | ✅ |
| CLI | eza, bat, fzf, zoxide, ripgrep, fd, jq, yq, lazygit, gh, direnv | ✅ | ✅ |
| Version manager | mise | ✅ | ✅ |

Shell là thứ **duy nhất** không dùng chung được (zsh và nushell là hai ngôn ngữ khác nhau).
Mọi thứ còn lại là một config cho mọi máy.

## Máy mới — 1 lệnh

```bash
DOTFILES_REPO=<git-url-repo-này> bash <(curl -fsSL <raw-url>/install.sh)
```

hoặc thủ công:

```bash
sh -c "$(curl -fsSL https://mise.run)"          # cài mise
mise use -g chezmoi
chezmoi init --apply <git-url-repo-này>          # clone + hỏi tên/email + apply + cài tool
chsh -s "$(which zsh)"                            # zsh làm mặc định
nvim                                              # LazyVim tự cài plugin
```

## Dùng hằng ngày

```bash
chezmoi edit ~/.zshrc        # sửa một dotfile (mở trong source)
chezmoi apply                # áp dụng thay đổi vào $HOME
chezmoi diff                 # xem trước thay đổi
chezmoi cd                   # vào thư mục source (git repo)
chezmoi re-add               # cập nhật source từ file đã sửa tay trong $HOME
```

Thêm tool mới: `mise use -g <tool>` → `chezmoi re-add ~/.config/mise/config.toml`.

## Cấu trúc

- `dot_*`            → file `~/.${...}` (vd `dot_zshrc` → `~/.zshrc`)
- `AppData/Roaming/` → chỉ Windows (destDir là `%USERPROFILE%`, `AppData` không có dấu chấm nên không cần `dot_`)
- `*.tmpl`           → template (danh tính, khác biệt OS)
- `.chezmoiignore`   → template; loại file theo OS. Match theo **target path**, không phải source path
- `.chezmoiexternal.toml` → tự clone zsh/tmux plugins (bỏ qua trên Windows)
- `.chezmoiscripts/` → script chạy khi apply (cài tool qua mise)

## Gate chặn secret

Repo này public, nên một secret lọt vào là nằm trong git history vĩnh viễn. Có
`.githooks/pre-commit` chạy [gitleaks](https://github.com/gitleaks/gitleaks) trên phần đã
stage. Git không tự bật hook khi clone (cố ý, để repo không tự chạy code của nó), nên bật tay:

```bash
git config core.hooksPath .githooks   # chạy 1 lần sau khi clone
```

gitleaks đã nằm trong `mise` nên `mise install` là có.

## Cấu hình riêng tư

Repo này là public. Những thứ không được lên đây — token, proxy công ty, host nội bộ,
email riêng cho từng nhóm dự án — để ở `~/.config/git/config-local`:

```ini
# ~/.config/git/config-local  (KHÔNG commit vào repo public)
[credential "https://git.noi-bo.company.vn"]
	provider = generic
# Email công ty chỉ áp cho repo trong ~/work/
[includeIf "gitdir:~/work/"]
	path = ~/.config/git/config-work
```

Nếu phải chỉnh thứ gì hạ mức bảo mật để lách hạ tầng công ty (ví dụ `http.sslVerify`),
luôn **scope theo host** — `[http "https://host-cu-the"]` — đừng bao giờ để ở mức global,
vì như vậy là tắt kiểm tra chứng chỉ cho cả `github.com` lẫn mọi nguồn khác.

`~/.gitconfig` kết thúc bằng `[include] path = ~/.config/git/config-local`. Git **bỏ qua
trong im lặng** nếu file đó không tồn tại, nên ai clone repo này về cũng chạy được ngay.
Muốn đồng bộ phần riêng tư giữa các máy thì để nó trong một repo private riêng.
