return {
	"jose-elias-alvarez/null-ls.nvim",
	event = "BufRead",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.prettierd,
			},
			on_attach = function(client, bufnr)
				-- Create a command `:Format` local to the LSP buffer
				vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
					vim.lsp.buf.format()
				end, { desc = "Format current buffer with LSP" })

				local lsp_map = require("helpers.keys").lsp_map
				lsp_map("<leader>F", "<cmd>Format<cr><cmd>EslintFixAll<cr>", bufnr, "Format")
			end,
		})
	end,
}
