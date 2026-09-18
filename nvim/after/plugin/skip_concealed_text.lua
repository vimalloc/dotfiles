vim.api.nvim_create_user_command("SkipConcealedText", function()
  local window_id = vim.api.nvim_get_current_win()
  local row, column = unpack(vim.api.nvim_win_get_cursor(window_id))
  local marks = vim.api.nvim_buf_get_extmarks(
    0,
    -1,
    { row - 1, column },
    { row - 1, column + 1 },
    { details = true, overlap = true }
  )

  for _, mark in ipairs(marks) do
    local details = mark[4]
    if details.conceal ~= nil then
      vim.api.nvim_win_set_cursor(window_id, { row, details.end_col + 1 })
      return
    end
  end
  vim.api.nvim_win_set_cursor(window_id, { row, column + 1 })
end, { desc = "Skip Concealed Text" })


-- TODO:
--   * External links should skip to the end of the link, not to the start of it.
--     Something with end_col probably. Figure out what to do there
--     * Fix: If there are multiple marks that have conceal, find the one that has
--       the larger value. Should fix this.
--   * Have this work for both right and left
--   * Nvim 13 has a new feature for next wrapping on external links I believe.
--     Figure that out when it drops
