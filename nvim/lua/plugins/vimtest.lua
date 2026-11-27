return {
  'vim-test/vim-test',
  keys = {
    { '<leader>tn', '<cmd>TestNearest<CR>' },
    { '<leader>tf', '<cmd>TestFile<CR>' },
    { '<leader>tl', '<cmd>TestLast<CR>' },
  },
  config = function()
    -- Fix for readline issue with binding.pry
    vim.g["test#ruby#rspec#executable"] = 'RUBYOPT="-W0" bundle exec rspec'
    vim.g["test#javascript#jest#executable"] = "pnpm jest"

    -- Settings for opening the split vim pane on test run
    vim.g["test#strategy"] = "neovim"
    vim.g["test#neovim#term_position"] = "horizontal botright 25"

    -- Use venv for python tests
    vim.g['test#python#pytest#executable'] = './venv/bin/pytest'

    -- Allow using escape to move to command mode in terminal and scroll upwards
    vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
  end
}
