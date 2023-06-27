return {
	{
		"code-biscuits/nvim-biscuits",
		event = "BufRead",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			local biscuits = require("nvim-biscuits")
			biscuits.setup({
				cursor_line_only = true,
				default_config = {
					min_distance = 10,
					max_length = 50,
					prefix_string = " 󰆘 ",
					prefix_highlight = "Comment",
					enable_linehl = true,
				},
			})
		end,
	},
}
