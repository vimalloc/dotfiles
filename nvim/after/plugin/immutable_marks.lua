vim.api.nvim_create_user_command("ImmutableMarks", function(mark_args)
  -- Use `dir` option with lazy to get this working without needing to to make a
  -- github repo that lazy pulls from. Maybe that would be good though? No idea,
  -- figure it out later

  local buffer = vim.api.nvim_get_current_buf()
  local all_marks = vim.fn.getmarklist(buffer)
  local map_keys = function(mark_object)
    return mark_object.mark
  end
  local marks = vim.tbl_map(map_keys, all_marks)

  mark_exists = vim.list_contains(marks, '\'.')
  vim.print(mark_exists)
end, { desc = "Immutable Marks" })

vim.keymap.set('n', 'm', '<cmd>ImmutableMarks<cr>')
