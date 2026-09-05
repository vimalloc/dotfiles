local obsidian_group = vim.api.nvim_create_augroup("ObsidianVault", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  group = obsidian_group,
  pattern = vim.fn.expand("~") .. "/Documents/Dnd_Vault/*.md",
  callback = function()
    vim.opt_local.conceallevel = 2
  end,
})

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  opts = {
    legacy_commands = false, -- this will be removed in 4.0.0
    workspaces = {
      {
        name = "Valeria",
        path = "~/Documents/Dnd_Vault",
      },
    },
  },
}
