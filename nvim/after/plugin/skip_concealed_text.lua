-- Both extmarks and treesitter are used to conceal different parts of the markdown
-- when using render-markdown. Just using Obsidian was so much simpler in that
-- regard, it was using extmarks for everything and just worked. Like, is the small
-- UI improvements I get with this setup worth it? ...Yeah probably. But it's
-- annoying to have to deal with.


-- Moving left on a wiki link, it hits an overeager treesitter conceal node,
-- which causes it to bypass the left most character in the link. Extmarks handles
-- this as expected, so just ignore treesitter in this case. Honestly, I *think*
-- the only thing we need treesitter for is external links. If that's true,
-- change this to only look at those (IIRC it was pattern id 9?)
local WIKI_LINK_ID = 16

local function get_next_col_treesitter(initial_col, handle_concealed)
  local window_id = vim.api.nvim_get_current_win()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(window_id))
  local next_col = initial_col

  local treesitter_nodes = vim.inspect_pos(0, row - 1, next_col - 1).treesitter
  for _, treesitter_node in ipairs(treesitter_nodes) do
    local conceal = treesitter_node.metadata.conceal
    local pattern_id = treesitter_node.pattern_id

    if conceal ~= nil and pattern_id ~= WIKI_LINK_ID then
      next_col = handle_concealed(next_col, next_col, next_col + 1)
      break
    end
  end

  return next_col
end

-- With overlap = true I'm kinda surprised we have to jump all the way to the
-- beginning or end, instead of letting us just move one character at a time. That
-- was totally broken for me when I first tried it, but maybe try again and see if
-- I was just doing it wrong, cause I really think it should just work according
-- to the docs.
local function get_next_col_extmarks(initial_col, handle_concealed)
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

  return next_col
end

local function set_next_col(initial_col, handle_concealed)
  local window_id = vim.api.nvim_get_current_win()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(window_id))
  local next_col = initial_col
  local previous_col = next_col

  while true do
    next_col = get_next_col_extmarks(next_col, handle_concealed)
    next_col = get_next_col_treesitter(next_col, handle_concealed)
    vim.api.nvim_win_set_cursor(window_id, { row, next_col })

    if next_col == previous_col then
      break
    end

    previous_col = next_col
  end
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
