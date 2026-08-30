vim.keymap.del("n", "]]", { buffer = true })
vim.keymap.del("n", "[[", { buffer = true })
vim.keymap.set({ "n", "t" }, "[[", function() Snacks.words.jump(vim.v.count1) end, { buffer = true, silent = true })
vim.keymap.set({ "n", "t" }, "]]", function() Snacks.words.jump(-vim.v.count1) end, { buffer = true, silent = true })
