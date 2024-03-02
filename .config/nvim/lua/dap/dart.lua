local M = {}

M.setup = function()
	local dap = require('dap')
	local dapui = require('dapui')
	dapui.setup()

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
			flutterSdkPath = "/Users/flutter/bin/flutter",                   -- ensure this is correct
			program = "${workspaceFolder}/lib/main.dart",                    -- ensure this is correct
			cwd = "${workspaceFolder}",
		},
		{
			type = "flutter",
			request = "launch",
			name = "Launch flutter",
			dartSdkPath = "/Users/flutter/bin/cache/dart-sdk/bin/dart", -- ensure this is correct
			flutterSdkPath = "/Users/flutter/bin/flutter",             -- ensure this is correct
			program = "${workspaceFolder}/lib/main.dart",              -- ensure this is correct
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
end

return M
