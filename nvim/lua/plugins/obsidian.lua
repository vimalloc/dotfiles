local WORKSPACES = {
  {
    name = "Valeria",
    path = vim.fn.expand("~") .. "/code/vaults/dnd",
  },
  {
    name = "Grad School Admissions",
    path = vim.fn.expand("~") .. "/code/vaults/admissions",
  },
}

local PATTERNS = vim.tbl_map(
  function(workspace)
    return workspace.path .. "/*.md"
  end,
  WORKSPACES
)

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  pattern = PATTERNS,
  callback = function()
    vim.keymap.set('v', '<leader>ln', '<cmd>Obsidian link_new<cr>', { buffer = true, silent = true })
  end,
})

local note_id_func = function(title)
  return title
end

-- This works, but it now sets an unnecessary alias on the referring wiki link. Figure that out
local note_path_func = function(spec)
  local filename = (spec.title or tostring(spec.id)):gsub(' ', '_')
  local path = spec.dir / filename
  return path:with_suffix(".md")
end

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  opts = {
    ui = {
      enable = false,
    },
    legacy_commands = false, -- this will be removed in 4.0.0
    workspaces = WORKSPACES,
    note_id_func = note_id_func,
    note_path_func = note_path_func,
    checkbox = {
      order = { " ", "x" },
    }
  },
}
