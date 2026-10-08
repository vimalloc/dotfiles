-- Both extmarks and treesitter are used to conceal different parts of the markdown
-- when using render-markdown. Just using Obsidian was so much simpler in that
-- regard, it was using extmarks for everything and just worked. Like, is the small
-- UI improvements I get with this setup worth it? ...Yeah probably. But it's
-- annoying to have to deal with.

local function get_next_col_treesitter(initial_col, handle_concealed)
  local window_id = vim.api.nvim_get_current_win()
  local row, col = unpack(vim.api.nvim_win_get_cursor(window_id))
  local next_col = initial_col
  local continue = true

  while continue do
    continue = false

    local treesitter_nodes = vim.inspect_pos(0, row - 1, next_col - 1).treesitter
    for _, treesitter_node in ipairs(treesitter_nodes) do
      if treesitter_node.metadata.conceal ~= nil then
        next_col = handle_concealed(next_col, next_col, next_col + 1)
        continue = true
        break
      end
    end
  end

  return next_col
end

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
  local row, col = unpack(vim.api.nvim_win_get_cursor(window_id))
  local next_col = initial_col
  local previous_next_col = next_col
  local changed_due_to_ext = false

  while true do
    next_col = get_next_col_extmarks(next_col, handle_concealed)
    vim.api.nvim_win_set_cursor(window_id, { row, next_col })

    if next_col ~= previous_next_col then
      vim.notify('ext hit')
      changed_due_to_ext = true
      previous_next_col = next_col
    else
      break
    end
  end

  -- We need this for external links, but is causes a conceal hit and character skip
  -- when traversing right across a [[Normal Link]] (`N` skipped in this case).
  -- Either figure out what's going on there, like are we going one loop to many
  -- or something. Or update this to only operate on external links via the
  -- treesitter group?
  --
  -- if changed_due_to_ext == false then
  --   vim.notify('treesitter hit')
  --   next_col = get_next_col_treesitter(next_col, handle_concealed)
  --   vim.api.nvim_win_set_cursor(window_id, { row, next_col })
  -- end
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
    -- Is this still needed now?
    local possible_prev_col = math.max(start_conceal_col - 1, 0)
    if possible_prev_col < current_col then
       return possible_prev_col
    else
      return current_col
    end
  end

  set_next_col(initial_col, handle_concealed)
end, { desc = "Skip Concealed Text Left" })
