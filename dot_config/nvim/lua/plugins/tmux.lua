-- Điều hướng liền mạch giữa split nvim và pane tmux bằng Ctrl-h/j/k/l
-- (khớp với cấu hình is_vim trong ~/.tmux.conf)
return {
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Sang pane/split trái" },
      { "<c-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Xuống pane/split dưới" },
      { "<c-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Lên pane/split trên" },
      { "<c-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Sang pane/split phải" },
    },
  },
}
