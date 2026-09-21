return {
  "dimtion/guttermarks.nvim",
  event = { "BufReadPost", "BufNewFile", "BufWritePre", "FileType" },
  config = function()
    vim.api.nvim_set_hl(0, "GutterMarksLocal", { fg = "#D62020" })
  end,
}
