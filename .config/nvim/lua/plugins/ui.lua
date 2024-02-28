return {
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"aserowy/tmux.nvim",
		event = "VimEnter",
		config = function()
			require("tmux").setup({
				copy_sync = {
					enable = false,
				},
				navigation = {
					cycle_navigation = false,
				},
				resize = {
					resize_step_x = 5,
					resize_step_y = 5,
				},
			})

			local map = require("helpers.keys").map
			map({ "n", "i", "t" }, "<C-h>", function()
				require("tmux").move_left()
			end)
			map({ "n", "i", "t" }, "<C-j>", function()
				require("tmux").move_bottom()
			end)
			map({ "n", "i", "t" }, "<C-k>", function()
				require("tmux").move_top()
			end)
			map({ "n", "i", "t" }, "<C-l>", function()
				require("tmux").move_right()
			end)
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		event = "VimEnter",
		config = function()
			local scrollbar = require("scrollbar")
			scrollbar.setup()
		end,
	},
	{
		"jinh0/eyeliner.nvim",
		event = "BufRead",
		config = function()
			require("eyeliner").setup({
				highlight_on_key = true, -- show highlights only after keypress
				dim = false,         -- dim all other characters if set to true (recommended!)
			})
		end,
	},
	{
		"chrisgrieser/nvim-early-retirement",
		config = function ()
			require("early-retirement").setup({
				ignoreFileNamePattern = "__FLUTTER_DEV_LOG__"
			})
		end,
		event = "VeryLazy",
	},
}
