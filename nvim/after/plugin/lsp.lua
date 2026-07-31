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

vim.keymap.set('n', '<leader>at', '<cmd>DiagnosticToggle<cr>', { noremap = true })

-- Code formatting stuff
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end)
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action)

-- View to code errors
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

-- Go to code errors
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- Jump to / from definitions
vim.keymap.set('n', 'gd', vim.lsp.buf.definition) -- Jump to method definition
vim.keymap.set('n', 'gr', vim.lsp.buf.references) -- Find where a method is used

-- rename variable in file (TS only, not available in ruby-lsp)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

-- Signatures
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

-- Setup the servers
local capabilities = vim.tbl_deep_extend("force",
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)

vim.lsp.config('eslint', {capabilities = capabilities})
vim.lsp.config('pyright', {capabilities = capabilities})
vim.lsp.config('ruby_lsp', {
  capabilities = capabilities,
  init_options = {
		addonSettings = {
			["Ruby LSP Rails"] = {
				enablePendingMigrationsPrompt = false,
			},
		},
	},
})
vim.lsp.config('ts_ls', {capabilities = capabilities})

vim.lsp.enable({'eslint'})
vim.lsp.enable({'pyright'})
vim.lsp.enable({'ruby_lsp'})
vim.lsp.enable({'ts_ls'})
