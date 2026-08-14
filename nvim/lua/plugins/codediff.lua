return {
  "esmuellert/codediff.nvim",
  opts = {
    diff = {
      layout = "inline",
      cycle_hunks_across_files = true,
    },
    explorer = {
      position = "bottom",
      hidden = false,
      focus_on_select = true,
      auto_open_on_cursor = true,
    },
    keymaps = {
      view = {
        next_hunk = "<leader>j",
        prev_hunk = "<leader>k",
      },
    },
  },
}
