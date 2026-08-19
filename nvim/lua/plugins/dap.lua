return {
  'mfussenegger/nvim-dap',
  dependencies = {
    "suketa/nvim-dap-ruby",
  },
  config = function ()
    local dap = require("dap")

    -- Keymaps: Maybe find better keys, keep doing 'bd' instead and closing window
    -- I know some configs suggested the F keys, maybe those??
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: Continue / Start' })
    vim.keymap.set('n', '<leader>dx', dap.terminate, { desc = 'Debug: Terminate Session' })
    vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = 'Debug: Open REPL' })
    vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Debug: Run Last Session' })
    vim.keymap.set('n', '<leader>dj', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<leader>do', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>dt', dap.run_to_cursor, { desc = 'Debug: Run to Cursor' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dC', function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end, { desc = 'Debug: Conditional Breakpoint' })
    vim.keymap.set({'n', 'v'}, '<leader>dh', function()
      require('dap.ui.widgets').hover()
    end, { desc = 'Debug: Hover Variables' })

    -- Javascript / Typescript dap setup. No plugin for this so have to do it more
    -- by hand. Also manually install vscode-js-debug, whicih is awful. It's an
    -- excuse to consider moving to mason, at least for this, cause in theory they
    -- do manage it which would be great.
    local js_debug = vim.fn.expand("~/.local/share/vscode-js-debug/")
    local js_debug_path = js_debug .. "vscode-js-debug-1.117.0-prebuilt/src/dapDebugServer.js"
    local js_debug_adapter = {
    -- Configure ruby dap (removing entries I don't want)
    require("dap-ruby").setup()
    local wanted_ruby_entries = {
      'run rspec current file',
      'run rspec current_file:current_line',
      'attach existing (port 38698)',
    }
    local good_ruby_configs = {}
    for _, ruby_config in ipairs(dap.configurations['ruby']) do
      if vim.list_contains(wanted_ruby_entries, ruby_config.name) then
        table.insert(good_ruby_configs, ruby_config)
      end
    end
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = { command = "node", args = { js_debug_path, "${port}" } },
    }
    dap.adapters["pwa-node"] = js_debug_adapter
    dap.configurations["typescript"] = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Jest (Current File)",
        program = "${workspaceFolder}/node_modules/jest/bin/jest.js",
        args = { "--config", "config/jest.json", "--runInBand", "${file}" },
        cwd = "${workspaceFolder}",
        env = { TZ = "America/Los_Angeles" },
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        sourceMaps = true,
      },
    }
  end
}
