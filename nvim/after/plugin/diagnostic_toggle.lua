-- Initial state
vim.diagnostic.config {
  virtual_text = true,
  underline = true,
  signs = true,
}

-- Toggle state, while keeping signs turned on regardless
vim.api.nvim_create_user_command("DiagnosticToggle", function()
  local config = vim.diagnostic.config
  local vt = config().virtual_text
  config {
    virtual_text = not vt,
    underline = not vt,
    signs = true,
  }
end, { desc = "Diagnostic Toggle" })

vim.keymap.set('n', '<leader>at', '<cmd>DiagnosticToggle<cr>')
