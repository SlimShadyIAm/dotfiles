-- Fancier statusline
return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				component_separators = "|",
				section_separators = "",
				disabled_filetypes = { "neo-tree" }
			},
		})
	end,
}
