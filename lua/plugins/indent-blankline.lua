return {
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			local indent = require("indent_blankline")
			indent.setup()
		end,
	},
}
