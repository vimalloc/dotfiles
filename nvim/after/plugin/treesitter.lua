local languages = {
  "bash",
  "javascript",
  "lua",
  "markdown",
  "python",
  "query",
  "ruby",
  "typescript",
  "vim",
  "vimdoc",
}

require('nvim-treesitter.configs').setup({
  ensure_installed = languages,
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
})
