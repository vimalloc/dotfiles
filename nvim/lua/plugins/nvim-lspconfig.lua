-- Inline diagnostic toggle
vim.diagnostic.config {
  virtual_text = true,
  underline = true,
  signs = true,
}

vim.api.nvim_create_user_command("DiagnosticToggle", function()
	local config = vim.diagnostic.config
	local vt = config().virtual_text
	config {
		virtual_text = not vt,
		underline = not vt,
		signs = true,
	}
end, { desc = "toggle diagnostic" })

return {
  "neovim/nvim-lspconfig",
  lazy = false,
  keys = {
    { '<leader>at', '<cmd>DiagnosticToggle<cr>' },

    -- Code formatting stuff
    { '<leader>f', function() vim.lsp.buf.format { async = true } end },
    { '<leader>ca', vim.lsp.buf.code_action },

     -- View to code errors
    { '<leader>e', vim.diagnostic.open_float },

  --   -- Jump to / from definitions
  --   { 'gd', vim.lsp.buf.definition }, -- Jump to method definition
  --   { 'gr', vim.lsp.buf.references }, -- Find where a method is used
  --
  --   -- Rename variable in file (TS only, not available in ruby-lsp
  --   { '<leader>rn', vim.lsp.buf.rename, opts },
  },
  config = function()
    vim.lsp.config('harper_ls', {
      -- filetypes = { 'markdown', 'text', 'jjdescription' },
      filetypes = { 'text', 'jjdescription' },
      settings = {
        ["harper-ls"] = {
          linters = {
            SpellCheck = false,
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

