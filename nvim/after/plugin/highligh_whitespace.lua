-- Highlight trailing whitespace
vim.api.nvim_set_hl(0, "ExtraWhitespace", { ctermbg = "green", bg = "green" })

vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
  callback = function()
    vim.cmd([[match ExtraWhitespace /\s\+$/]])
  end
})

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.cmd([[match ExtraWhitespace /\s\+\%#\@<!$/]])
  end
})
