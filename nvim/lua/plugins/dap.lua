return {
  'mfussenegger/nvim-dap',
  dependencies = {
    "suketa/nvim-dap-ruby",
  },
  config = function ()
    require("dap-ruby").setup()

    local dap = require("dap")

    -- Execution & Sessions
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: Continue / Start' })
    vim.keymap.set('n', '<leader>dx', dap.terminate, { desc = 'Debug: Terminate Session' })
    vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = 'Debug: Open REPL' })
    vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Debug: Run Last Session' })

    -- Stepping navigation
    vim.keymap.set('n', '<leader>dj', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<leader>do', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>dt', dap.run_to_cursor, { desc = 'Debug: Run to Cursor' })

    -- Breakpoint Management
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dC', function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end, { desc = 'Debug: Conditional Breakpoint' })

    -- Variable Inspection (Widgets)
    vim.keymap.set({'n', 'v'}, '<leader>dh', function()
      require('dap.ui.widgets').hover()
    end, { desc = 'Debug: Hover Variables' })

    local js_debug = vim.fn.expand("~/.local/share/vscode-js-debug/")
    local js_debug_path = js_debug .. "vscode-js-debug-1.117.0-prebuilt/src/dapDebugServer.js"

    local js_debug_adapter = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = { command = "node", args = { js_debug_path, "${port}" } },
    }
    dap.adapters["pwa-node"] = js_debug_adapter
    dap.adapters["pwa-chrome"] = js_debug_adapter

    local debug_languages = { "javascript", "typescript" }
    for _, lang in ipairs(debug_languages) do
      dap.configurations[lang] = {
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
  end
}

-- Consider mason (booo) cause it can install vscode-js-debug in theory without
-- needing to do the manual install that I'm going to forget about.
