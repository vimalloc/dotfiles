local function set_next_col(initial_col, handle_concealed)
  local window_id = vim.api.nvim_get_current_win()
  local row, col = unpack(vim.api.nvim_win_get_cursor(window_id))
  local marks = vim.api.nvim_buf_get_extmarks(
    0,
    -1,
    { row - 1, col },
    { row - 1, col + 1 },
    { details = true, overlap = true }
  )

  local next_col = initial_col
  for _, mark in ipairs(marks) do
    local start_conceal_col, details = mark[3], mark[4]
    local end_conceal_col = details.end_col

    if details.conceal ~= nil then
      next_col = handle_concealed(next_col, start_conceal_col, end_conceal_col)
    end
  end

  vim.api.nvim_win_set_cursor(window_id, { row, next_col })
end

vim.api.nvim_create_user_command("SkipConcealedTextRight", function()
  local window_id = vim.api.nvim_get_current_win()
  local row, col = unpack(vim.api.nvim_win_get_cursor(window_id))
  local initial_col = col + 1

  local handle_concealed = function(current_col, conceal_start_col, end_conceal_col)
    if current_col < end_conceal_col then
      return end_conceal_col
    else
      return current_col
    end
  end

  set_next_col(initial_col, handle_concealed)
end, { desc = "Skip Concealed Text Right" })

vim.api.nvim_create_user_command("SkipConcealedTextLeft", function()
  local window_id = vim.api.nvim_get_current_win()
  local row, col = unpack(vim.api.nvim_win_get_cursor(window_id))
  local initial_col = math.max(col - 1, 0)

  local handle_concealed = function(current_col, start_conceal_col, end_conceal_col)
    local possible_prev_col = math.max(start_conceal_col - 1, 0)
    if possible_prev_col < current_col then
       return possible_prev_col
    else
      return current_col
    end
  end

  set_next_col(initial_col, handle_concealed)
end, { desc = "Skip Concealed Text Left" })
