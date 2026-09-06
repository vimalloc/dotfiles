return {
  "folke/flash.nvim",
  event = "VeryLazy",
  keys = {
    { "t", false },
    { "T", false },
    { "F", false }, -- This is not unbinding F. Maybe another plugin defines it
    { "f",
      mode = { "n", "x", "o" },
      function() require("flash").jump() end,
      desc = "Flash Jump"
    },
    -- TODO: This only works once when bound to F, then it stops searching.
    { "r",
      mode = { "n", "x", "o" },
      function() require("flash").treesitter_search() end,
      desc = "Flash Treesitter Search"
    },
  },
}
