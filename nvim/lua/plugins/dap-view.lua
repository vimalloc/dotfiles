return {
  "igorlfs/nvim-dap-view",
  version = "1.*",
  opts = {
    winbar = {
      default_section = "repl",
      sections = { "repl", "breakpoints",  "watches", "scopes", "exceptions", "console", },
    },
    windows = {
      size = 0.4,
    },
  },
}
