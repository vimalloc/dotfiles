vim.api.nvim_create_user_command("SkipConcealedText", function()
  local window_id = vim.api.nvim_get_current_win()
  local row, col = unpack(vim.api.nvim_win_get_cursor(window_id))
  local marks = vim.api.nvim_buf_get_extmarks(
    0,
    -1,
    { row - 1, col },
    { row - 1, col + 1 },
    { details = true, overlap = true }
  )

  next_col = col + 1
  for _, mark in ipairs(marks) do
    local details = mark[4]
    if details.conceal ~= nil then
      possible_next_col = details.end_col + 1
      if possible_next_col > next_col then
        next_col = possible_next_col
      end
    end
  end
  vim.api.nvim_win_set_cursor(window_id, { row, next_col })
end, { desc = "Skip Concealed Text" })


-- TODO:
--   * Have this work for both right and left
--   * Nvim 13 has a new feature for next wrapping on external links I believe.
--     Figure that out when it drops
