-- set up dap for debugging using lazy
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"Weissle/persistent-breakpoints.nvim",
			"leoluz/nvim-dap-go",
		},
		config = function()
			local dap = require('dap')
			local dapui = require('dapui')
			dapui.setup()

			-- Set up some keybindings
			local map = require('helpers.keys').map

			require("nvim-dap-virtual-text").setup({
				commented = true,
			})

			require('dap.dart').setup()
			require('dap.go').setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open({})
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close({})
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close({})
			end

			require('persistent-breakpoints').setup {
				load_breakpoints_event = { "BufReadPost" }
			}


			-- change breakpoint symbol
			local dap_breakpoint = {
				error = {
					text = "🛑",
					texthl = "LspDiagnosticsSignError",
					linehl = "",
					numhl = "",
				},
				rejected = {
					text = "",
					texthl = "LspDiagnosticsSignHint",
					linehl = "",
					numhl = "",
				},
				stopped = {
					text = "⭐️",
					texthl = "LspDiagnosticsSignInformation",
					linehl = "DiagnosticUnderlineInfo",
					numhl = "LspDiagnosticsSignInformation",
				},
			}

			vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
			vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
			vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

			-- Keybindings
			map("n", "<leader>db", "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>",
				"Toggle breakpoint")
			map("n", "<leader>dc", dap.continue, "Continue")
			map("n", "<leader>dd", ":lua require('dapui').toggle()<CR>", "Toggle DAP UI")
			map("n", "<leader>dj", ":lua require('dap').step_over()<CR>", "Step over")
			map("n", "<leader>di", ":lua require('dap').step_into()<CR>", "Step into")
			map("n", "<leader>do", ":lua require('dap').step_out()<CR>", "Step out")
			map("n", "<leader>dr", ":lua require('dap').repl.toggle()<CR>", "Toggle REPL")
		end
	},
}
