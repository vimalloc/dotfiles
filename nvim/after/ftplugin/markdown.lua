-- 2 space tabs
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

-- Disable line numbers. Funky to use them when using wrapped lines instead of
-- physical newlines
vim.opt_local.number = false

-- Wrap lines on word boundaries
vim.opt_local.linebreak = true

-- Indent wrapped lines to the same level as the line they are wrapped from
vim.opt_local.breakindent = true
vim.opt_local.breakindentopt = "list:-1"

-- Conceal options
vim.opt_local.conceallevel = 3
vim.opt.concealcursor = "n"

-- Treat wrapped lines as physical newlines when navigating
vim.keymap.set("n", "k", "gk", { buffer = true, silent = true })
vim.keymap.set("n", "j", "gj", { buffer = true, silent = true })
vim.keymap.set("n", "0", "g0", { buffer = true, silent = true })
vim.keymap.set("n", "$", "g$", { buffer = true, silent = true })

-- Markdown link color
vim.api.nvim_set_hl(0, '@markup.link.label.markdown_inline', { fg = '#4ba4f3' })

-- Hookup our custom commands
vim.keymap.set('n', 'l', vim.cmd.SkipConcealedTextRight, { buffer = true, silent = true })
vim.keymap.set('n', 'h', vim.cmd.SkipConcealedTextLeft, { buffer = true, silent = true })
vim.keymap.set('n', '<leader>st', vim.cmd.InlineStrikethrough)
