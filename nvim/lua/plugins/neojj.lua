return {
  "NicholasZolton/neojj",
  version = "^1.0.0",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "esmuellert/codediff.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = Neojj,
  keys = {
    { "<leader>gg", "<cmd>Neojj<cr>", desc = "Show Neojj UI" }
  },
  opts = {
    codediff_tab_position = "before",
    commit_view = {
      kind = "split",
    },
    sections = {
      recent = {
        folded = false,
        hidden = false,
      },
      bookmarks = {
        folded = false,
        hidden = true,
        show_deleted = false,
        show_remote = false,
      },
    },
  },
}
