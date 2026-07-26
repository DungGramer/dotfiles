# ───────────────────────────────────────────────────────────────────────────
#  Font terminal cho máy MỚI trên WINDOWS: Cascadia Code NF (Microsoft).
#  Chạy 1 lần mỗi máy:   powershell -ExecutionPolicy Bypass -File system-fonts.ps1
#
#  Song song với system-apps.sh (Linux) — thứ Windows-only, KHÔNG do chezmoi apply lo.
#
#  Vì sao phải có script riêng, không nhét vào chezmoi run_once:
#   - Windows Terminal (DirectWrite) KHÔNG thấy font cài per-user (scoop mặc định cài
#     per-user) → phải cài machine-wide (C:\Windows\Fonts + HKLM), mà cái đó cần ADMIN.
#   - chezmoi apply chạy non-elevated nên không tự làm machine-wide được.
#   Script tự xin UAC cho đúng bước machine-wide, phần còn lại chạy quyền user.
#
#  Chọn Cascadia Code NF (bản Microsoft, VARIABLE): có icon Nerd Font + trục weight
#  liên tục nên đặt weight = "medium" (500) ra đúng mức giữa Regular↔SemiBold.
# ───────────────────────────────────────────────────────────────────────────
param([string]$MachineWideFrom)   # nội bộ: nhánh self-elevated chỉ làm machine-wide

$ErrorActionPreference = 'Stop'

# ══ Nhánh ELEVATED (admin): chỉ copy variable font machine-wide + đăng ký HKLM ══
if ($MachineWideFrom) {
    $dst  = "$env:WINDIR\Fonts"
    $hklm = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts'
    Add-Type -AssemblyName System.Drawing
    Add-Type @"
using System; using System.Runtime.InteropServices;
public class FontApi {
  [DllImport("gdi32.dll")] public static extern int AddFontResource(string p);
  [DllImport("user32.dll")] public static extern int SendMessage(IntPtr h, uint m, IntPtr w, IntPtr l);
}
"@
    # chỉ lấy các file NF (có icon); bỏ bản không-NF
    Get-ChildItem $MachineWideFrom -Recurse -Filter *.ttf | Where-Object { $_.Name -match 'NF' } | ForEach-Object {
        $target = Join-Path $dst $_.Name
        Copy-Item $_.FullName $target -Force
        [void][FontApi]::AddFontResource($target)
        $pfc = New-Object System.Drawing.Text.PrivateFontCollection
        try { $pfc.AddFontFile($target); $fam = $pfc.Families[0].Name } catch { $fam = [IO.Path]::GetFileNameWithoutExtension($_.Name) }
        New-ItemProperty -Path $hklm -Name "$fam (TrueType)" -Value $_.Name -PropertyType String -Force | Out-Null
    }
    [void][FontApi]::SendMessage([IntPtr]0xffff, 0x001D, [IntPtr]::Zero, [IntPtr]::Zero)  # WM_FONTCHANGE
    return
}

# ══ 1) Quyền USER: scoop + font qua bucket nerd-fonts ══
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    throw "Chưa có scoop. Cài trước: iwr -useb get.scoop.sh | iex"
}
if (-not (scoop bucket list | Where-Object { $_.Name -eq 'nerd-fonts' })) {
    Write-Host ">> thêm bucket nerd-fonts…"; scoop bucket add nerd-fonts
}
if (-not (Test-Path "$env:USERPROFILE\scoop\apps\Cascadia-Code\current")) {
    Write-Host ">> cài Cascadia-Code (Microsoft)…"; scoop install Cascadia-Code
}
$srcDir = "$env:USERPROFILE\scoop\apps\Cascadia-Code\current"

# ══ 2) Machine-wide (ADMIN): tự elevate, WT mới thấy được ══
$id = [Security.Principal.WindowsIdentity]::GetCurrent()
if (-not (New-Object Security.Principal.WindowsPrincipal($id)).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host ">> cài font machine-wide (cần admin — bấm Yes ở UAC)…"
    Start-Process powershell -Verb RunAs -Wait -ArgumentList `
        "-NoProfile","-ExecutionPolicy","Bypass","-File","`"$PSCommandPath`"","-MachineWideFrom","`"$srcDir`""
}

# ══ 3) Trỏ Windows Terminal vào font (quyền user, chỉ chỉnh nếu WT có mặt) ══
$wt = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
if (Test-Path $wt) {
    $raw = Get-Content $wt -Raw
    $font = '"font": { "face": "Cascadia Code NF", "weight": "medium" }'
    if ($raw -match '"defaults":\s*\{\s*"font":\s*\{[^}]*\}\s*\}') {
        $raw = $raw -replace '"defaults":\s*\{\s*"font":\s*\{[^}]*\}\s*\}', "`"defaults`": { $font }"
    } elseif ($raw -match '"defaults":\s*\{\}') {
        $raw = $raw -replace '"defaults":\s*\{\}', "`"defaults`": { $font }"
    }
    [System.IO.File]::WriteAllText($wt, $raw, (New-Object System.Text.UTF8Encoding($false)))
    Write-Host ">> đã đặt WT font = Cascadia Code NF (weight medium)."
    Write-Host "   THOÁT HẲN Windows Terminal rồi mở lại để nhận font (không chỉ đóng tab)."
} else {
    Write-Host ">> Không thấy Windows Terminal — font đã cài, tự đặt trong terminal bạn dùng:"
    Write-Host "   face = 'Cascadia Code NF', weight = medium (hoặc số 400-600)."
}

Write-Host "✅ Font xong."
