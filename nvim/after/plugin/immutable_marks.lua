local last_ran_time = 0
local delta_to_allow_reset_mark = 500

vim.api.nvim_create_user_command("ImmutableMarks", function()
  -- Bail if escape. Probably more codes should be here, but only one I can think of
  local new_mark = vim.fn.getcharstr()
  if string.byte(new_mark) == 27 then
    return
  end

  local buffer = vim.api.nvim_get_current_buf()
  local all_marks = vim.fn.getmarklist(buffer)
  local map_keys = function(mark_object) return mark_object.mark end
  local marks = vim.tbl_map(map_keys, all_marks)
  local new_formatted_mark = "\'" .. new_mark
  local mark_exists = vim.list_contains(marks, new_formatted_mark)

  local current_time = vim.uv.hrtime() / 1e6
  local elapsed = current_time - last_ran_time
  last_ran_time = current_time

  if mark_exists and elapsed > delta_to_allow_reset_mark then
    vim.notify("Mark already exists. Use :delmarks! to remove", vim.log.levels.ERROR)
    return
  end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_mark(buffer, new_mark, row, col, {})
end, { desc = "Immutable Marks" })

vim.keymap.set('n', 'm', '<cmd>ImmutableMarks<cr>')
