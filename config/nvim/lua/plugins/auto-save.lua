return {
  {
    opts = {},
    "Pocco81/auto-save.nvim",
    event = "BufRead",
    config = function()
      local autosave = require("auto-save")
      autosave.setup({
        trigger_events = { "InsertLeave" }
    })
    end,
  },
}
