-- Nicer filetree than NetRW
return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup()
			local map = require("helpers.keys").map

			map({ "n", "v" }, "<leader>he", "<cmd>NeoTreeRevealToggle<cr>", "Toggle file explorer")
			map({ "n", "v" }, "<leader>e", "<C-w><C-w>", "Focus file explorer")
			vim.api.nvim_create_autocmd("VimEnter", {
				command = "set nornu nonu | Neotree toggle",
			})
		end,
	},
}
