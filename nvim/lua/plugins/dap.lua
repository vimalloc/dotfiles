return {
  'mfussenegger/nvim-dap',
  config = function ()
    local dap = require("dap")

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dap-repl",
      callback = function()
        vim.keymap.set({ "i", "n" }, "<C-d>", function()
          dap.repl.close({ mode = "toggle" })
        end, { buffer = true })
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dap-repl",
      callback = function()
        vim.keymap.set({ "i", "n" }, "<C-l>", function()
          dap.repl.clear()
        end, { buffer = true })
      end,
    })

    -- Not sure why we need both. Don't care enough to fix right now
    dap.listeners.before.attach.lily_open_repl = function()
      dap.repl.open()
    end

    dap.listeners.before.launch.lily_open_repl = function()
      dap.repl.open()
    end

    vim.keymap.set('n', '<Right>', dap.step_into, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<Left>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<Down>', dap.step_over, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<Up>', dap.restart_frame, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, { desc =  'Breakpoint' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Continue / Start' })
    vim.keymap.set({'n', 'v'}, '<leader>dr', function()
      dap.repl.open()
    end, { desc = 'Open Repl' })

    -- Typescript dap setup. No plugin for this so have to do it more by hand.
    -- Also manually install vscode-js-debug, which is awful. It's an excuse to
    -- consider moving to mason, at least for this, cause in theory they do manage
    -- it which would be great.
    local ts_debug = vim.fn.expand("~/.local/share/vscode-js-debug/")
    local ts_debug_path = ts_debug .. "vscode-js-debug-1.117.0-prebuilt/src/dapDebugServer.js"
    local ts_debug_adapter = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = { command = "node", args = { ts_debug_path, "${port}" } },
    }
    dap.adapters["pwa-node"] = ts_debug_adapter
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
