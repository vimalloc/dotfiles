-- Strike through all the text on line under the cursor, ignoring headings, checkboxes, etc.
vim.api.nvim_create_user_command("InlineStrikethrough", function()
  local node = vim.treesitter.get_node()

  if not node or node:type() ~= 'inline' then
    return
  end

  local start_row, start_col, end_row, end_col = node:range()
  local current_line = vim.api.nvim_buf_get_lines(0, end_row, end_row + 1, false)[1]
  local start_character = current_line:sub(start_col + 1, start_col + 1)
  local end_character = current_line:sub(end_col, end_col)

  if start_character == '~' and end_character == '~' then
    vim.api.nvim_buf_set_text(0, end_row, end_col - 1, end_row, end_col, {})
    vim.api.nvim_buf_set_text(0, start_row, start_col, start_row, start_col + 1, {})
  else
    vim.api.nvim_buf_set_text(0, end_row, end_col, end_row, end_col, { '~' })
    vim.api.nvim_buf_set_text(0, start_row, start_col, start_row, start_col, { '~' })
  end
end, { desc = "Inline Strikethrough" })

vim.keymap.set('n', '<leader>st', '<cmd>InlineStrikethrough<cr>')
