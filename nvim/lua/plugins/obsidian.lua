local WORKSPACES = {
  {
    name = "Valeria",
    path = vim.fn.expand("~") .. "/Documents/Dnd_Vault",
  },
  {
    name = "Books",
    path = vim.fn.expand("~") .. "/Documents/books",
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
    vim.opt_local.conceallevel = 2
  end,
})

local note_id_func = function(title) return title end

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  opts = {
    legacy_commands = false, -- this will be removed in 4.0.0
    workspaces = WORKSPACES,
    note_id_func = note_id_func,
  },
}
