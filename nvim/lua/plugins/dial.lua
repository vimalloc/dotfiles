return {
  "monaqa/dial.nvim",
  keys = {
    { "<C-a>",
      function() require("dial.map").manipulate("increment", "normal") end,
      desc = "Dial Increment"
    },
    { "<C-x>",
      function() require("dial.map").manipulate("decrement", "normal") end,
      desc = "Dial Decrement"
    },
  },
  config = function()
    local dial_config = require("dial.config")
    local augend = require("dial.augend")

    dial_config.augends:register_group({
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.constant.new({
          elements = { "true", "false" },
          word = true,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "success", "failure" },
          word = true,
          cyclic = true,
        }),
      },
    })
  end,
}
