local DIRECTIONS = {
  Left = 0,
  Right = 1,
}

local function move_col(col, direction, jump)
  jump = jump or 1

  if direction == DIRECTIONS.Left then
    return math.max(col - jump, 0)
  elseif direction == DIRECTIONS.Right then
    return col + jump
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
    if details ~= nil and details.virt_text_hide == false then
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

local function is_treesitter_node(col, node_type)
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local node = vim.treesitter.get_node({ pos = { row - 1, col } })
  return node and node:type() == node_type
end

local function get_inspect_data(initial_col)
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local inspect_opts = {
    extmarks = 'all',
    semantic_tokens = false,
    syntax = false,
    treesitter = true,
  }
  if initial_col == 1 and is_treesitter_node(0, 'inline') then
    return vim.inspect_pos(0, row - 1, 0, inspect_opts)
  else
    return vim.inspect_pos(0, row - 1, initial_col, inspect_opts)
  end
end

local function get_next_col(initial_col, direction)
  if is_treesitter_node(initial_col, 'list_marker_minus') then
    local jump = direction == DIRECTIONS.Right and 2 or 1
    return move_col(initial_col, direction, jump)
  end

  if is_left_virt_text_edge(initial_col) then
    return initial_col
  end

  local inspect = get_inspect_data(initial_col)

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

local function set_next_col(direction)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local next_col = move_col(col, direction)
  local prev_col = next_col

  while true do
    next_col = get_next_col(next_col, direction)
    if next_col == prev_col then
      break
    end
    prev_col = next_col
  end

  vim.api.nvim_win_set_cursor(0, { row, next_col })
end

vim.api.nvim_create_user_command("SkipConcealedTextRight", function()
  set_next_col(DIRECTIONS.Right)
end, { desc = "Skip Concealed Text Right" })

vim.api.nvim_create_user_command("SkipConcealedTextLeft", function()
  set_next_col(DIRECTIONS.Left)
end, { desc = "Skip Concealed Text Left" })
