return {
	{
		-- autoclose tags
		"m4xshen/autoclose.nvim",
		event = "InsertEnter",
		config = function()
			local autoclose = require("autoclose")
			autoclose.setup()
		end,
	},
}

