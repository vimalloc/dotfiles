vim.keymap.set('n', 'r', function ()
  require('leap').leap { target_windows = { vim.api.nvim_get_current_win() } }
end)
