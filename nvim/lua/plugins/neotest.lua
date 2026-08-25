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
      discovery = {
        concurrent = 0,
       enabled = false
      },
    })

    -- TODO debug file isn't working
    vim.keymap.set('n', '<leader>tn', function()
      require("neotest").run.run()
    end, { desc = 'Run nearest test' })

    vim.keymap.set('n', '<leader>dn', function()
      require("neotest").run.run({strategy = "dap"})
    end, { desc = 'Debug nearest test' })

    vim.keymap.set('n', '<leader>tf', function()
      require("neotest").run.run(vim.fn.expand("%"))
    end, { desc = 'Run test file' })

    vim.keymap.set('n', '<leader>df', function()
      require("neotest").run.run({vim.fn.expand("%"), strategy = "dap"})
    end, { desc = 'Debug file' })
  end
}
