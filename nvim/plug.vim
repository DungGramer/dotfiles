if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shime/vim-livedown' " Live server for HTML
Plug 'sbdchd/neoformat'  " Formatting Code
Plug 'preservim/nerdtree' " File tree
if has("nvim")
  " Dashboard
  Plug 'glepnir/dashboard-nvim'

  Plug 'kristijanhusak/defx-git'
  Plug 'kristijanhusak/defx-icons'
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'tami5/lspsaga.nvim'
  Plug 'folke/lsp-colors.nvim'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'ryanoasis/vim-devicons'
  Plug 'nvim-lua/popup.nvim'

  " Language Server Protocol
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'folke/trouble.nvim' " showing diagnostics, errors, warnings
  Plug 'onsails/lspkind-nvim'
  Plug 'creativenull/diagnosticls-configs-nvim'

  " Javascript
  Plug 'vim-test/vim-test'
  Plug 'tpope/vim-commentary' " Commenting

  " File Management
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-telescope/telescope-file-browser.nvim'
  Plug 'sudormrfbin/cheatsheet.nvim'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'ThePrimeagen/harpoon'
  Plug 'GustavoKatel/sidebar.nvim' " Sidebar

  Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'elijahmanor/export-to-vscode.nvim'

  " Status line
  Plug 'hoob3rt/lualine.nvim'
  Plug 'kyazdani42/nvim-web-devicons'

  Plug 'windwp/nvim-autopairs'
  Plug 'windwp/nvim-ts-autotag'
  Plug 'nvim-lua/completion-nvim' " Auto completion

  Plug 'norcalli/nvim-colorizer.lua' " Show hex color


  " tmux plugins
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'preservim/vimux'
endif

Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

call plug#end()
