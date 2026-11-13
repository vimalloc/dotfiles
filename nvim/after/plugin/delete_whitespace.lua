-- Delete trailing whitespace. Considering running this code when closing a buffer
vim.api.nvim_create_user_command("DeleteWhitespace", function()
  if vim.api.nvim_buf_get_name(0) == "" then
    return
  end

  if vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "" then
    return
  end

  vim.cmd("%s/\\s\\+$//ge")
  vim.cmd("nohlsearch")
  if vim.bo.modified then
    vim.cmd("silent! write")
  end
end, { desc = "Delete Trailing Whitespac" })
