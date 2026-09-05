vim.api.nvim_create_user_command("SqlFormatter", function()
  local buffer_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local text = table.concat(buffer_lines, "\n")
  local cmd = "sql-formatter --config \z
              '{ \"keywordCase\": \"upper\" }' \z
              --language postgresql"

  local output = vim.fn.system(cmd, text)
  local exit_code = vim.v.shell_error
  if exit_code != 0 then
    vim.notify("Could ot format sql", vim.log.levels.ERROR)
    return
  end

  local formatted_sql = vim.split(output, "\n")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted_sql)
  vim.bo.filetype = "sql"
end, { desc = "SQL Formatter" })

vim.keymap.set('n', '<leader>ss', '<cmd>SqlFormatter<cr>')
