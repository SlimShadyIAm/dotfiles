return {
  {
    "andweeb/presence.nvim",
    event = "BufRead",
    lazy = false,
    config = function()
      local discord_presence = require("presence")
      discord_presence.setup({
        blacklist = { 'carp' }
      })
    end,
  }
}
