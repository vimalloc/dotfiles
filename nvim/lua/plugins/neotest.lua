return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "antoinemadec/FixCursorHold.nvim",
    "olimorris/neotest-rspec",
  },
  log_level = vim.log.levels.DEBUG,
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-rspec")
      },
    })
  end
}
