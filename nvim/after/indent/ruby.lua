-- I have no idea why, but the `.` indent key, set in nvim proper
-- (/opt/homebrew/Cellar/neovim/0.12.5_1/share/nvim/runtime/indent/ruby.vim) is
-- causing issues where the indentation gets messed up when `.` is pushed for like
-- calling a method on something. No idea why this just started breaking now.
--
-- I can't put this in after/ftplugin/ruby.lua because the nvim code runs after that
-- code, so the changes don't persist. I need to do it here to get around that.
vim.opt_local.indentkeys:remove(".")
