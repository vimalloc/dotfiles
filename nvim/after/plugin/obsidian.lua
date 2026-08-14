require("obsidian").setup({
  workspaces = { { name = "dnd", path = "~/Documents/Dnd_Vault" } },
  completion = { nvim_cmp = true, min_chars = 2 },
  disable_frontmatter = true,
  ui = { enable = false },
})
