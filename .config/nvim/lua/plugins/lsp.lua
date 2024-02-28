local on_attach = function(client, bufnr)
	local lsp_map = require("helpers.keys").lsp_map

	lsp_map("<leader>lr", vim.lsp.buf.rename, bufnr, "Rename symbol")
	lsp_map("<leader>la", vim.lsp.buf.code_action, bufnr, "Code action")
	lsp_map("<leader>lh", vim.lsp.buf.hover, bufnr, "Type definition")
	lsp_map("<leader>ls", require("telescope.builtin").lsp_document_symbols, bufnr,
		"Document symbols")

	lsp_map("<leader>gd", "<cmd>Telescope lsp_definitions<cr>", bufnr, "Goto Definition")
	lsp_map("<leader>gr", require("telescope.builtin").lsp_references, bufnr,
		"Goto References")
	lsp_map("<leader>gI", vim.lsp.buf.implementation, bufnr, "Goto Implementation")

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
	lsp_map("<leader>F", "<cmd>Format<cr>", bufnr, "Format")


	-- Attach and configure vim-illuminate
	require("illuminate").on_attach(client)
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- LSP Configuration & Plugins
return {
	{
		"neovim/nvim-lspconfig",
		event = "BufRead",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{
				"j-hui/fidget.nvim",
				tag = "legacy",
				event = "LspAttach",
			},
			{
				'akinsho/flutter-tools.nvim',
				lazy = false,
				dependencies = {
					"dart-lang/dart-vim-plugin",
					'nvim-lua/plenary.nvim',
					'stevearc/dressing.nvim', -- optional for vim.ui.select
				},
			},
			"folke/neodev.nvim",
			"RRethy/vim-illuminate",
			"hrsh7th/cmp-nvim-lsp",
			"b0o/schemastore.nvim",
			"RobertBrunhage/dart-tools.nvim",
			"dart-lang/dart-vim-plugin",
		},
		config = function()
			-- Set up Mason before anything else
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pylsp",
					"tailwindcss",
				},
				automatic_installation = true,
			})

			-- Quick access via keymap
			require("helpers.keys").map("n", "<leader>M", "<cmd>Mason<cr>", "Show Mason")

			-- Neodev setup before LSP config
			require("neodev").setup()

			-- Turn on LSP status information
			require("fidget").setup()

			-- Set up cool signs for diagnostics
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			-- Diagnostic config
			local config = {
				virtual_text = true,
				signs = {
					active = signs,
				},
				update_in_insert = true,
				underline = true,
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			}
			vim.diagnostic.config(config)

			-- This function gets run when an LSP connects to a particular buffer.

			-- Lua
			require("lspconfig")["lua_ls"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			})

			-- Python
			require("lspconfig")["pyright"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
			require("lspconfig")["eslint"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			require("lspconfig")["tailwindcss"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
			require("lspconfig")["jsonls"].setup({
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
					},
				},
			})

			local dartExcludedFolders = {
				vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
				vim.fn.expand("$HOME/.pub-cache"),
				vim.fn.expand("/opt/homebrew/"),
				vim.fn.expand("$HOME/tools/flutter/"),
			}

			require('flutter-tools').setup {
				lsp = {
					on_attach = on_attach,
					capabilities = capabilities,
					color = {
						enabled = true,
						virtual_text = true,
						background = true,
					}
				},
				dev_log = {
					open_cmd = 'belowright 14new',
				},
			}

			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = vim.api.nvim_create_augroup("code_action_sign", { clear = true }),
				callback = function()
					require('helpers.code_action_utils').code_action_listener()
				end,
			})
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
		config = function()
			require("typescript-tools").setup({
				settings = {
					tsserver_plugins = {
						"@styled/typescript-styled-plugin",
					},
				},
			})
		end,
	},
}
