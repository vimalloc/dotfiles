require('telescope').load_extension('fzf')

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { remap = false })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { remap = false })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { remap = false })
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { remap = false })
