-- Themes
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    event = "VimEnter",
    config = function()
      require('catppuccin').setup({
        flavor = 'mocha',
        integrations = {
          gitsigns = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
          },
          harpoon = true,
          mason = true,
          noice = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
          notify = true,
          neotree = true,
          which_key = true,
        }
      })
    end
  },
}
