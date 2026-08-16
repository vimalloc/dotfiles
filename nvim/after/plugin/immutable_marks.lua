vim.api.nvim_create_user_command("ImmutableMarks", function()
  -- Use `dir` option with lazy to get this working without needing to to make a
  -- github repo that lazy pulls from. Maybe that would be good though? No idea,
  -- figure it out later

  -- Bail if escape. Probably more codes should be here, but only one I can think of
  local new_mark = vim.fn.getcharstr()
  if string.byte(new_mark) == 27 then
    return
  end

  local buffer = vim.api.nvim_get_current_buf()
  local all_marks = vim.fn.getmarklist(buffer)
  local map_keys = function(mark_object)
    return mark_object.mark
  end
  local marks = vim.tbl_map(map_keys, all_marks)

  new_formatted_mark = "\'" .. new_mark
  mark_exists = vim.list_contains(marks, new_formatted_mark)
  if mark_exists then
    vim.notify("Mark already exists. Use :delmarks! to remove", vim.log.levels.ERROR)
    return
  end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_mark(buffer, new_mark, row, col, {})
end, { desc = "Immutable Marks" })

vim.keymap.set('n', 'm', '<cmd>ImmutableMarks<cr>')
