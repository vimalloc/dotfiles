return {
  "dimtion/guttermarks.nvim",
  event = { "BufReadPost", "BufNewFile", "BufWritePre", "FileType" },
  config = function()
    vim.api.nvim_set_hl(0, "GutterMarksLocal", { fg = "#73C2FB" })
    require('guttermarks').setup({
      priority = 0
    })
  end,
}
