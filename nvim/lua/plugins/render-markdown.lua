return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  opts = {
    enabled = true,
    checkbox = {
      enabled = true,
      left_pad = 0,
      right_pad = 1,
    },
    render_modes = { 'n', 'i', 'v', 'V', 'c', 't' },
    win_options = {
      concealcursor = { rendered = 'n' },
    },
    anti_conceal = {
      disabled_modes = { 'n' },
    },
  },
}
