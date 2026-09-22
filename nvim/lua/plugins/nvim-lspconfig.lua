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
            AvoidCurses = false,
            ToDoHyphen = false,
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

    -- This error annoying as hell and not actually an issue, it just shows up if I
    -- delete something that had an lsp warning before the lsp finishes loading.
    local lsp_client = require('vim.lsp.client')
    local orig_write_error = lsp_client.write_error
    lsp_client.write_error = function(self, code, err)
      if vim.lsp.rpc.client_errors[code] == "NO_RESULT_CALLBACK_FOUND" then
        return
      end
      orig_write_error(self, code, err)
    end
  end,
}
