# Dotfiles (chezmoi)

Setup dev cá nhân — quản lý bằng [chezmoi](https://chezmoi.io), tool cài bằng [mise](https://mise.jdx.dev).

## Thành phần

| Lĩnh vực | Công cụ |
|---|---|
| Terminal | Ghostty |
| Multiplexer | tmux (smart pane nav Ctrl-hjkl, copy clipboard OSC52) |
| Shell | zsh + autosuggestions + fast-syntax-highlighting + fzf-tab |
| Prompt | starship |
| History | atuin (Ctrl-R) |
| Editor | Neovim + LazyVim |
| Git | delta (diff đẹp), alias, push.autoSetupRemote |
| CLI | eza, bat, fzf, zoxide, ripgrep, fd, jq, yq, lazygit, gh, direnv |
| Version manager | mise (node, python, neovim, + các CLI tool) |

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
- `*.tmpl`           → template (chèn tên/email theo máy)
- `.chezmoiexternal.toml` → tự clone zsh plugins
- `.chezmoiscripts/` → script chạy khi apply (cài tool qua mise)
