return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufRead",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.prettierd
        },
        on_attach = function(client, bufnr)
          -- Create a command `:Format` local to the LSP buffer
          vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
            vim.lsp.buf.format()
          end, { desc = "Format current buffer with LSP" })

          local lsp_map = require("helpers.keys").lsp_map
          lsp_map("<leader>F", "<cmd>Format<cr><cmd>EslintFixAll<cr>", bufnr, "Format")

          if client.supports_method("textDocument/formatting") then
            -- if you want format on save
            -- vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            -- vim.api.nvim_create_autocmd("BufWritePre", {
            --   group = augroup,
            --   buffer = bufnr,
            --   callback = function()
            --     vim.lsp.buf.format({
            --       bufnr = bufnr,
            --       filter = function(client)
            --         return client.name == "null-ls"
            --       end,
            --     })
            --   end,
            -- })
          end
        end,
      })
    end,
  },
}
