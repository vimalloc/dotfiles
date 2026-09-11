-- TODO:
--   * External links have conceal in multiple locations in the markdown, some of which
--     which are not in extmarks at all
--   * If last items in column are concealed, do not move cursor over them
--   * Support going forward or backward.
local function is_concealed(row, column)
  local marks = vim.api.nvim_buf_get_extmarks(
    0, -1, { row, column }, { row, column },
    { details = true, overlap = true }
  )

  -- what does mcolumn mean? Better naming?
  for _, mark in ipairs(marks) do
    local mcolumn, details = mark[3], mark[4]
    if details.conceal ~= nil then
      local end_column = details.end_column or (mcolumn + 1)
      if column >= mcolumn and column < end_column then
        return true
      end
    end
  end
  return false
end

vim.api.nvim_create_user_command("SkipConcealedText", function()
  local window_id = vim.api.nvim_get_current_win()
  local row, column = unpack(vim.api.nvim_win_get_cursor(window_id))
  local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]

  while column < #line do
    column = column + 1
    if not is_concealed(row, column) then
      break
    end
  end

  vim.api.nvim_win_set_cursor(window_id, { row, column })
end, { desc = "Skip Concealed Text" })
