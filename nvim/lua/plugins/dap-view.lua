return {
  "igorlfs/nvim-dap-view",
  version = "1.*",
  opts = {
    winbar = {
      default_section = "repl",
      sections = { "repl", "breakpoints", "console", "watches", "scopes", "exceptions", },
    },
    windows = {
      size = 0.4,
    },
    auto_toggle = 'keep_terminal',
  },
}
