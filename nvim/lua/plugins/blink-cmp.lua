return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'none',
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
    },

    appearance = {
      nerd_font_variant = 'mono'
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = { implementation = "rust" },

    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = false
        },
      },
    },
  },
  opts_extend = { "sources.default" }
}

-- include parens? Not helpful for standalone methods, but help for for others?
