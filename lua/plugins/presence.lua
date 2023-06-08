return {
  {
    "andweeb/presence.nvim",
    lazy = false,
    config = function()
      local discord_presence = require("presence")
      discord_presence.setup({
        blacklist = { 'carp' }
      })
    end,
  }
}
