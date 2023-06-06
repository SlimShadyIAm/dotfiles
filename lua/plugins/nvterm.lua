return {
	{
		"NvChad/nvterm",
		config = function()
			require("nvterm").setup()
			local map = require("helpers.keys").map
			map("n", "<leader>tv", function()
				require("nvterm.terminal").toggle "vertical"
			end
			, "Toggle vertical terminal")
			map("n", "<leader>tt", function()
				require("nvterm.terminal").toggle "horizontal"
			end
			)
			map("t", "jk", "<C-\\><C-n>", "Exit Terminal mode")
		end,
	},
}
