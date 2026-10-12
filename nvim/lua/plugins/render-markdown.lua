return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  opts = {
    enabled = true,
    injections = {},
    completions = {
      blink = { enabled = true },
    },
    checkbox = {
      enabled = true,
      left_pad = 0,
      right_pad = 1,
    },
    render_modes = { 'n', 'i', 'v', 'V', 'c', 't', 'no' },
    win_options = {
      concealcursor = { rendered = 'n' },
    },
    anti_conceal = {
      disabled_modes = { 'n' },
    },
    heading = {
      width = 'block',
      right_pad = 1,
      sign = false,
    },
  },
}
