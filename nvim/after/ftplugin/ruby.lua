local forward = function() Snacks.words.jump(1) end
local backward = function() Snacks.words.jump(-1) end

vim.keymap.set({ "n", "t" }, "[[", forward, { buffer = true, silent = true })
vim.keymap.set({ "n", "t" }, "]]", backward, { buffer = true, silent = true })
