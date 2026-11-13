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

local note_path_func = function(spec)
  local filename = (spec.title or tostring(spec.id)):gsub(' ', '_'):lower()
  local path = spec.dir / filename
  return path:with_suffix(".md")
end

local wiki_link_alias_only = function(opts)
  local header_or_block = ""
  if opts.anchor then
    header_or_block = string.format("#%s", opts.anchor.header)
  elseif opts.block then
    header_or_block = string.format("#%s", opts.block.id)
  end
  return string.format("[[%s%s]]", opts.label, header_or_block)
end

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  opts = {
    legacy_commands = false, -- this will be removed in 4.0.0
    checkbox = {
      order = { " ", "x" },
    },
    note_id_func = note_id_func,
    note_path_func = note_path_func,
    link = {
      style = wiki_link_alias_only,
    },
    ui = {
      enable = false,
    },
    workspaces = WORKSPACES,
  }
}
