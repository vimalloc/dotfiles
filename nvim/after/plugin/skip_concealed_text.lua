-- Moving left on a wiki link, it hits an overeager treesitter conceal node,
-- which causes it to bypass the left most character in the link. Extmarks handles
-- this as expected, so just ignore treesitter in this case.
local WIKI_LINK_ID = 16
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
  local window_id = vim.api.nvim_get_current_win()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(window_id))
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

local function is_last_virt_text_col(col)
  local prev_col_virt_text = is_virt_text_displayed(col, col + 1)
  local prev_prev_col_virt_text = is_virt_text_displayed(col - 1, col)

  return prev_col_virt_text and not prev_prev_col_virt_text
end

local function get_next_col_treesitter(initial_col, direction)
  local window_id = vim.api.nvim_get_current_win()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(window_id))
  local treesitter_nodes = vim.inspect_pos(0, row - 1, initial_col - 1).treesitter

  for _, treesitter_node in ipairs(treesitter_nodes) do
    local conceal = treesitter_node.metadata.conceal
    local pattern_id = treesitter_node.pattern_id

    if conceal ~= nil and pattern_id ~= WIKI_LINK_ID then
      return move_col(initial_col, direction)
    end
  end

  return initial_col
end

local function get_next_col_extmarks(initial_col, direction)
  local marks = get_marks(initial_col, initial_col)

  for _, mark in ipairs(marks) do
    local details = mark[4]

    if details.conceal ~= nil and initial_col ~= details.end_col then
      return move_col(initial_col, direction)
    end
  end

  return initial_col
end

local function set_next_col(initial_col, direction)
  local next_col = initial_col
  local prev_col = initial_col

  while not is_last_virt_text_col(next_col) do
    next_col = get_next_col_treesitter(next_col, direction)
    next_col = get_next_col_extmarks(next_col, direction)

    if next_col == prev_col then
      break
    end

    prev_col = next_col
  end

  local window_id = vim.api.nvim_get_current_win()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(window_id))
  vim.api.nvim_win_set_cursor(window_id, { row, next_col })
end

vim.api.nvim_create_user_command("SkipConcealedTextRight", function()
  local window_id = vim.api.nvim_get_current_win()
  local _, col = unpack(vim.api.nvim_win_get_cursor(window_id))
  local initial_col = move_col(col, DIRECTIONS.Right)
  set_next_col(initial_col, DIRECTIONS.Right)
end, { desc = "Skip Concealed Text Right" })

vim.api.nvim_create_user_command("SkipConcealedTextLeft", function()
  local window_id = vim.api.nvim_get_current_win()
  local _, col = unpack(vim.api.nvim_win_get_cursor(window_id))
  local initial_col = move_col(col, DIRECTIONS.Left)
  set_next_col(initial_col, DIRECTIONS.Left)
end, { desc = "Skip Concealed Text Left" })
