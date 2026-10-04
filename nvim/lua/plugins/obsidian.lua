local WORKSPACES = {
  {
    name = "Valeria",
    path = vim.fn.expand("~") .. "/code/vaults/dnd",
  },
  {
    name = "Books",
    path = vim.fn.expand("~") .. "/code/vaults/books",
  },
  {
    name = "Masters Social Work",
    path = vim.fn.expand("~") .. "/code/vaults/msw",
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
    vim.opt_local.conceallevel = 2
    vim.opt.concealcursor = "n"

    local keymap_opts = { buffer = true, silent = true }
    vim.keymap.set('n', 'l', '<cmd>SkipConcealedTextRight<cr>', keymap_opts)
    vim.keymap.set('n', 'h', '<cmd>SkipConcealedTextLeft<cr>', keymap_opts)
    vim.keymap.set('v', '<leader>ln', '<cmd>Obsidian link_new<cr>', keymap_opts)

    -- Move this somewhere else. Also wtf guys why is this necessary. TODO
    vim.api.nvim_set_hl(0, '@markup.link.label.markdown_inline', { fg = '#4ba4f3' })
  end,
})

local note_id_func = function(title) return title end

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
    checkbox = {
      order = { " ", "x" },
    }
  },
}
