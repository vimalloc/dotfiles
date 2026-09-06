return {
  "folke/flash.nvim",
  event = "VeryLazy",
  keys = {
    { "t", false },
    { "T", false },
    { "f",
      mode = { "n", "x", "o" },
      function() require("flash").jump() end,
      desc = "Flash Jump"
    },
    { "F",
      mode = { "n", "x", "o" },
      function() require("flash").treesitter_search() end,
      desc = "Flash Treesitter Search"
    },
  },
}
