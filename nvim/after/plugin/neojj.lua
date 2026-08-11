local neojj = require('neojj')

vim.keymap.set(
  "n",
  "<leader>gg",
  function() neojj.open({ kind = "replace" }) end,
  { desc = "Open Neojj UI" }
)
