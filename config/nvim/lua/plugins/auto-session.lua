return {
  {
    "rmagatti/auto-session",
    event = "VimEnter",
    config = function()
      local autosession = require("auto-session")
      autosession.setup({})
    end,
  },
}
