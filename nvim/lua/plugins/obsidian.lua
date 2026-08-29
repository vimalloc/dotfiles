return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",

  ---@module 'obsidian'
  ---@type obsidian.config
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
