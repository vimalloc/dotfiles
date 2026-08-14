local neojj = require("neojj")

neojj.setup({
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
})

vim.keymap.set(
  "n",
  "<leader>gg",
  function() neojj.open({ kind = "replace" }) end,
  { desc = "Open Neojj UI" }
)
