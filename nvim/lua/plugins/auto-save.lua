-- Remember the on-disk mtime each buffer was last read/written at, so autosave
-- can refuse to clobber a file that changed (or was deleted) behind our back.
local function stat_mtime(path)
  local stat = path ~= "" and vim.uv.fs_stat(path)
  return stat and (stat.mtime.sec .. "." .. stat.mtime.nsec) or nil
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "FileChangedShellPost" }, {
  group = vim.api.nvim_create_augroup("AutoSaveMtime", {}),
  callback = function(args)
    vim.b[args.buf].autosave_mtime = stat_mtime(vim.api.nvim_buf_get_name(args.buf))
  end,
})

-- Reload unmodified buffers when the file changes on disk
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("AutoSaveChecktime", {}),
  command = "silent! checktime",
})

return {
  "okuuva/auto-save.nvim",
  event = { "InsertLeave", "TextChanged" },
  opts = {
    condition = function(buf)
      if vim.bo[buf].buftype ~= "" then
        return false
      end

      local path = vim.api.nvim_buf_get_name(buf)
      if path == "" then
        return false
      end

      local known = vim.b[buf].autosave_mtime
      local current = stat_mtime(path)

      if current == nil then
        -- Not on disk: skip if it's an empty new file, or if it existed when we
        -- read it and has since been deleted.
        local empty = vim.api.nvim_buf_line_count(buf) == 1
          and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == ""
        return not empty and known == nil
      end

      -- On disk: only save if it hasn't changed since we last read/wrote it
      return current == known
    end,
  },
}
