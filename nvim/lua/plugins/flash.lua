return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      char = {
        keys = {}, -- Clear default f/F/t/T keybinds so I can use my own
      },
    },
  },
  keys = {
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
