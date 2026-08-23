languages = {
  "bash",
  "dap_repl",
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

return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-dap-repl-highlights').setup()
    require('nvim-treesitter').install(languages)
    require('nvim-treesitter').setup({})

    vim.api.nvim_create_autocmd('FileType', {
      pattern = languages,
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'ruby' },
        callback = function() 
          vim.treesitter.start()
      end,
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'typescript' },
        callback = function()
          vim.treesitter.start()
      end,
    })
  end
}
