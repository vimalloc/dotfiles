languages = {
  "bash",
  "fish",
  "javascript",
  "jjdescription",
  "lua",
  "markdown",
  "python",
  "query",
  "ruby",
  "sql",
  "typescript",
  "vim",
  "vimdoc",
}

require('nvim-treesitter').install(languages)
require('nvim-treesitter').setup({})

vim.api.nvim_create_autocmd('FileType', {
  pattern = languages,
  callback = function()
    vim.treesitter.start()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
