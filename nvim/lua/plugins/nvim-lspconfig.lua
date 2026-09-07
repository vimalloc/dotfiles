return {
  "neovim/nvim-lspconfig",
  lazy = false,
  keys = {
    -- Jump to / from definitions handled by snacks.lua

    -- Code formatting stuff
    { '<leader>f', function() vim.lsp.buf.format { async = true } end },
    { '<leader>ca', vim.lsp.buf.code_action },

     -- View errors
    { '<leader>e', vim.diagnostic.open_float },
  },
  config = function()
    vim.lsp.config('harper_ls', {
      filetypes = { 'markdown', 'text', 'jjdescription' },
      settings = {
        ["harper-ls"] = {
          linters = {
            SpellCheck = false,
            ExpandConfiguration = false,
          },
        }
      },
    })

    vim.lsp.config('ruby_lsp', {
      init_options = {
        addonSettings = {
          ["Ruby LSP Rails"] = {
            enablePendingMigrationsPrompt = false,
          },
        },
      },
    })

    vim.lsp.enable({'eslint'})
    vim.lsp.enable({'harper_ls'})
    vim.lsp.enable({'pyright'})
    vim.lsp.enable({'ruby_lsp'})
    vim.lsp.enable({'ts_ls'})
  end
}

