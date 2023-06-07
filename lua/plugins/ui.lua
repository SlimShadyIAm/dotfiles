
return {
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			local ident = require("indent_blankline")
			ident.setup()
		end,
	},
}
