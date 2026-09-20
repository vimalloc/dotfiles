return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  opts = {
    enabled = function()
      local ignore_list = { "jjdescription", "text", "markdown" }
      return not vim.tbl_contains(ignore_list, vim.bo.filetype)
    end,
    keymap = {
      preset = 'none',
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
    },
    appearance = {
      nerd_font_variant = 'mono',
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lsp = { fallbacks = {} }
      },
    },
    fuzzy = { implementation = "rust" },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}
