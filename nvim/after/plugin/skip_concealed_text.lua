local DIRECTIONS = {
  Left = 0,
  Right = 1,
}

local function move_col(col, direction)
  if direction == DIRECTIONS.Left then
    return math.max(col - 1, 0)
  elseif direction == DIRECTIONS.Right then
    return col + 1
  else
    error('Invalid Direction')
  end
end

local function get_marks(start_col, end_col)
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local marks = vim.api.nvim_buf_get_extmarks(
    0,
    -1,
    { row - 1, start_col },
    { row - 1, end_col },
    { details = true, overlap = true }
  )

  return marks
end

local function is_virt_text_displayed(col_start, col_end)
  local marks = get_marks(col_start, col_end)

  for _, mark in ipairs(marks) do
    local details = mark[4]
    if details.virt_text_hide == false then
      return true
    end
  end

  return false
end

local function is_left_virt_text_edge(col)
  local col_virt_text = is_virt_text_displayed(col, col + 1)
  local prev_col_virt_text = is_virt_text_displayed(col - 1, col)

  return col_virt_text and not prev_col_virt_text
end

local function get_next_col(initial_col, direction)
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local inspect_opts = {
    extmarks = 'all',
    semantic_tokens = false,
    syntax = false,
    treesitter = true,
  }
  local inspect = vim.inspect_pos(0, row - 1, initial_col, inspect_opts)

  for _, extmark in ipairs(inspect.extmarks) do
    if extmark.opts.conceal ~= nil and initial_col ~= extmark.opts.end_col then
      return move_col(initial_col, direction)
    end
  end

  for _, treesitter_node in ipairs(inspect.treesitter) do
    if treesitter_node.metadata.conceal ~= nil then
      return move_col(initial_col, direction)
    end
  end

  return initial_col
end

local function set_next_col(initial_col, direction)
  local next_col = initial_col
  local prev_col = initial_col

  while not is_left_virt_text_edge(next_col) do
    next_col = get_next_col(next_col, direction)
    if next_col == prev_col then
      break
    end
    prev_col = next_col
  end

  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_win_set_cursor(0, { row, next_col })
end

vim.api.nvim_create_user_command("SkipConcealedTextRight", function()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local initial_col = move_col(col, DIRECTIONS.Right)
  set_next_col(initial_col, DIRECTIONS.Right)
end, { desc = "Skip Concealed Text Right" })

vim.api.nvim_create_user_command("SkipConcealedTextLeft", function()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local initial_col = move_col(col, DIRECTIONS.Left)
  set_next_col(initial_col, DIRECTIONS.Left)
end, { desc = "Skip Concealed Text Left" })
