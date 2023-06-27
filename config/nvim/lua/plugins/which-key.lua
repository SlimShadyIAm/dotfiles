return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")
			wk.setup()
			wk.register(
				{
					["<leader>"] = {
						f = { name = "Find" },
						d = { name = "Delete/Close" },
						q = { name = "Quit" },
						l = { name = "LSP" },
						g = { name = "Goto" },
						t = { name = "Terminal" },
					},
				}
			)
		end
	}
}
