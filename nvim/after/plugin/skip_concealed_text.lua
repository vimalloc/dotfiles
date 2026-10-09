-- Both extmarks and treesitter are used to conceal different parts of the markdown
-- when using render-markdown. Just using Obsidian was so much simpler in that
-- regard, it was using extmarks for everything and just worked. Like, is the small
-- UI improvements I get with this setup worth it? ...Yeah probably. But it's
-- annoying to have to deal with.

local function move_col(col, direction)
  if direction == 'left' then
    return math.max(col - 1, 0)
  elseif direction == 'right' then
    return col + 1
  else
    error('Invalid Direction')
  end
end

-- Moving left on a wiki link, it hits an overeager treesitter conceal node,
-- which causes it to bypass the left most character in the link. Extmarks handles
-- this as expected, so just ignore treesitter in this case.
local WIKI_LINK_ID = 16

local function get_next_col_treesitter(initial_col, direction)
  local window_id = vim.api.nvim_get_current_win()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(window_id))
  local treesitter_nodes = vim.inspect_pos(0, row - 1, initial_col - 1).treesitter

  for _, treesitter_node in ipairs(treesitter_nodes) do
    local conceal = treesitter_node.metadata.conceal
    local pattern_id = treesitter_node.pattern_id

    if conceal ~= nil and pattern_id ~= WIKI_LINK_ID then
      return {
        move_col(initial_col, direction),
        false
      }
    end
  end

  return { initial_col, false }
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

local function start_on_virt_text()
  local window_id = vim.api.nvim_get_current_win()
  local _, col = unpack(vim.api.nvim_win_get_cursor(window_id))
  return is_virt_text_displayed(col, col + 1)
end

local function get_next_col_extmarks(initial_col, direction)
  local marks = get_marks(initial_col, initial_col)
  local start_on_virt_text = start_on_virt_text()
  local next_col = initial_col

  for _, mark in ipairs(marks) do
    local start_conceal_col, details = mark[3], mark[4]

    if direction == 'right' then
      if details.virt_text_hide == false and not start_on_virt_text then
        return { start_conceal_col - 1, true }
      end
    elseif direction == 'left' then
      -- Refactor Something like last virt text col
      local prev_col_virt_text = is_virt_text_displayed(next_col, next_col + 1)
      local prev_prev_col_virt_text = is_virt_text_displayed(
        next_col - 1, next_col
      )
      if prev_col_virt_text == true and prev_prev_col_virt_text == false then
        return { initial_col, true }
      end
    end

    if details.conceal ~= nil and initial_col ~= details.end_col then
      next_col = move_col(initial_col, direction)
    end
  end

  return { next_col, false }
end

-- TODO
--   * Better way to avoid having to pass true/false back to set_next_col in order
--     to know when you're on a virt mark and need to stop. Like calculate it on
--     that function and base off that.
--   * Any merit for a separate `get_next_virt_mark` type function, that if it
--     returns we don't run any of the other ones? Might not be clean.
--   * Is enum type a thing for lua? left and right?
--   * Reorganize functions to be in a better order
--   * Note that we are not doing anything generalized for virt text at all. This is
--     very specific to icons that are one col long and on the left side of the
--     link. Will break in lots of fun ways if thrown at other things.

local function set_next_col(initial_col, direction)
  local window_id = vim.api.nvim_get_current_win()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(window_id))

  local on_virt_text = false
  local next_col = initial_col
  local previous_col = initial_col

  while true do
    next_col, _ = unpack(get_next_col_treesitter(next_col, direction))
    next_col, on_virt_text = unpack(get_next_col_extmarks(next_col, direction))

    if on_virt_text or next_col == previous_col then
      break
    end

    previous_col = next_col
  end

  vim.api.nvim_win_set_cursor(window_id, { row, next_col })
end

vim.api.nvim_create_user_command("SkipConcealedTextRight", function()
  local window_id = vim.api.nvim_get_current_win()
  local _, col = unpack(vim.api.nvim_win_get_cursor(window_id))
  local initial_col = move_col(col, 'right')
  set_next_col(initial_col, 'right')
end, { desc = "Skip Concealed Text Right" })

vim.api.nvim_create_user_command("SkipConcealedTextLeft", function()
  local window_id = vim.api.nvim_get_current_win()
  local _, col = unpack(vim.api.nvim_win_get_cursor(window_id))
  local initial_col = move_col(col, 'left')
  set_next_col(initial_col, 'left')
end, { desc = "Skip Concealed Text Left" })

