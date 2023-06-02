return {
	{
		"ErichDonGubler/lsp_lines.nvim",
		config = function()
			local lsplines = require("lsp_lines")
			lsplines.setup()
		end,
	},
}
