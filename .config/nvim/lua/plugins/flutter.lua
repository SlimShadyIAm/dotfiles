return {
	{
		'akinsho/flutter-tools.nvim',
		dependencies = {
			"dart-lang/dart-vim-plugin",
		},
		lazy = false,
		dependencies = {
			'nvim-lua/plenary.nvim',
			'stevearc/dressing.nvim', -- optional for vim.ui.select
		},
		config = function()
			require("flutter-tools").setup {
				debugger = {
					enabled = false,
					run_via_dap = false,
					register_configurations = function(_)

					end
				}
			} -- use defaults
		end,
	}
}
