languages = {
  "bash",
  "fish",
  "javascript",
  "jjdescription",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "ruby",
  "sql",
  "typescript",
  "vim",
  "vimdoc",
}

return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install(languages)
    require('nvim-treesitter').setup({})

    vim.opt.foldlevelstart = 99
    vim.api.nvim_create_autocmd('FileType', {
      pattern = languages,
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'
      end,
    })
  end
}
