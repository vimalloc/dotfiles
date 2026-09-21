local last_ran_time = 0
local delta_to_allow_reset_mark = 500

local function last_ran_within_delta()
  local current_time = vim.uv.hrtime() / 1000000
  local elapsed = current_time - last_ran_time

  last_ran_time = current_time

  return elapsed > delta_to_allow_reset_mark
end

vim.api.nvim_create_user_command("ImmutableMarks", function()
  -- Bail if escape key
  local mark = vim.fn.getcharstr()
  if string.byte(mark) == 27 then
    return
  end

  local buffer = vim.api.nvim_get_current_buf()
  local mark_objects = vim.fn.getmarklist(buffer)
  local mark_object_to_char = function(mark_object)
    return mark_object.mark:gsub("\'", "")
  end
  local marks = vim.tbl_map(mark_object_to_char, mark_objects)
  local mark_exists = vim.list_contains(marks, mark)

  if mark_exists and last_ran_within_delta() then
    vim.notify("Mark already exists", vim.log.levels.ERROR)
    return
  end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_mark(buffer, mark, row, col, {})
end, { desc = "Immutable Marks" })

vim.keymap.set('n', 'm', '<cmd>ImmutableMarks<cr>')
