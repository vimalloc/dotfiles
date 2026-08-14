return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>' },
  },
  config = function()
    require('telescope').load_extension('fzf')
  end
}
