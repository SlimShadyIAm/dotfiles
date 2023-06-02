-- Fancier statusline
return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = 'palenight',
				component_separators = "|",
				section_separators = "",
				disabled_filetypes = { "neo-tree" }
			},
		})
	end,
}
