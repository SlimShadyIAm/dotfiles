-- set up dap for debugging using lazy
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"Weissle/persistent-breakpoints.nvim"
		},
		config = function()
			-- Set up some keybindings
			local map = require('helpers.keys').map

			local dap = require('dap')
			local dapui = require('dapui')
			dapui.setup()


			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			require('persistent-breakpoints').setup {
				load_breakpoints_event = { "BufReadPost" }
			}

			-- Dart / Flutter
			dap.adapters.dart = {
				type = 'executable',
				command = 'dart',
				args = { 'debug_adapter' }
			}
			dap.adapters.flutter = {
				type = 'executable',
				command = 'flutter',
				args = { 'debug_adapter' }
			}
			dap.configurations.dart = {
				{
					type = "dart",
					request = "launch",
					name = "Launch dart",
					dartSdkPath = "/Users/shady/flutter/bin/cache/dart-sdk/bin/dart", -- ensure this is correct
					flutterSdkPath = "/Users/flutter/bin/flutter",               -- ensure this is correct
					program = "${workspaceFolder}/lib/main.dart",                -- ensure this is correct
					cwd = "${workspaceFolder}",
				},
				{
					type = "flutter",
					request = "launch",
					name = "Launch flutter",
					dartSdkPath = "/Users/flutter/bin/cache/dart-sdk/bin/dart", -- ensure this is correct
					flutterSdkPath = "/Users/flutter/bin/flutter",         -- ensure this is correct
					program = "${workspaceFolder}/lib/main.dart",          -- ensure this is correct
					cwd = "${workspaceFolder}",
				},
				{
					name = "attach",
					request = "attach",
					type = "dart",
					cwd = "${workspaceFolder}",
					vmServiceUri = function()
						local value = vim.fn.input('VM Service URI: ')
						if value ~= '' then
							return value
						end
					end

				},
			}

			-- change breakpoint symbol
			vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

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
