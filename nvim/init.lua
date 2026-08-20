-- Leader <space>
vim.g.mapleader = " "

-- Unmap help key
vim.keymap.set({ "n", "v", "o" }, "<F1>", "<Esc>")
vim.keymap.set("i", "<F1>", "<Esc>")

-- Do not persist marks on vim close (bad for immutable_marks)
vim.opt.shada:append("'0")
vim.opt.shada:remove("'100")

-- Spacing
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Indenting
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Searching
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Vim command tab completion
vim.opt.wildmode = { "longest", "list" }

-- Middle-click paste
vim.opt.mouse = "v"

-- Line numbers
vim.opt.number = true
vim.opt.colorcolumn = "85"

-- Special keymaps for copying to system clipboard
vim.keymap.set({ "n", "v", "o" }, "<C-y>", '"*y')
vim.keymap.set({ "n", "v", "o" }, "<C-p>", '"*p')

-- Highlight current cursorline
vim.opt.cursorline = true

-- Highlight trailing whitespace
vim.api.nvim_set_hl(0, "ExtraWhitespace", { ctermbg = "green", bg = "green" })

vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
  callback = function()
    vim.cmd([[match ExtraWhitespace /\s\+$/]])
  end
})

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.cmd([[match ExtraWhitespace /\s\+\%#\@<!$/]])
  end
})

-- Delete trailing whitespace. Considering running this code when closing a buffer
local function deleteWhitespace()
  if vim.api.nvim_buf_get_name(0) == "" then
    return nil
  end

  if vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "" then
    return nil
  end

  vim.cmd("%s/\\s\\+$//g")
  vim.cmd("nohlsearch")
  vim.cmd("silent! update")
end

vim.keymap.set('n', '<leader>wt', deleteWhitespace)

vim.api.nvim_create_autocmd({ "BufUnload" }, {
  buffer = 0,
  callback = deleteWhitespace
})

-- Backup, swap, etc
vim.opt.backup = true
vim.opt.writebackup = true
vim.opt.swapfile = true
vim.opt.undofile = true
vim.opt.backupdir = { vim.fn.expand("~/.cache/vim") }
vim.opt.directory = { vim.fn.expand("~/.cache/vim/") }
vim.opt.undodir = { vim.fn.expand("~/.cache/vim/undodir") }

-- Ensure cache dirs exist
vim.fn.mkdir(vim.fn.expand("~/.cache/vim/undodir"), "p")

-- Faster previous / next / delete buffers
vim.keymap.set("n", "<leader>bp", "<cmd>bp<cr>")
vim.keymap.set("n", "<leader>bn", "<cmd>bn<cr>")
vim.keymap.set("n", "<leader>bd", "<cmd>bd!<cr>")

-- sql_formatter
vim.keymap.set("n", "<leader>ss", ":%!sql-formatter --config '{ \"keywordCase\": \"upper\" }' --language postgresql %<CR>")

-- Faster no highlight search
vim.keymap.set("n", "<leader>no", "<cmd>nohls<cr>")

-- Spellcheck (code comments and 'it' (etc) blocks
vim.opt.spell = true

-- Fix the mistype that I keep hitting when trying to fix a misspelled word
vim.keymap.set("n", "z-", "z=")

-- Misc keybindings to remember
-- ctrl-i        -> Go to previous jump
-- ctrl-o        -> Go to next jump
-- z=            -> Bring up the suggested replacements
-- zg            -> Good word: Add the word under the cursor to the dictionary
-- zw            -> Woops! Undo and remove the word from the dictionary

-- Load plugins
require('config.lazy')

-- Color (must be after plugins)
vim.cmd("colorscheme catppuccin-frappe")

