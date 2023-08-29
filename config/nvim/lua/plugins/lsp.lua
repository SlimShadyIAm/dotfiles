-- LSP Configuration & Plugins
return {
  {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
      "folke/neodev.nvim",
      "RRethy/vim-illuminate",
      "hrsh7th/cmp-nvim-lsp",
      "b0o/schemastore.nvim"
    },
    config = function()
      -- Set up Mason before anything else
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pylsp",
          "eslint",
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
      local on_attach = function(client, bufnr)
        local lsp_map = require("helpers.keys").lsp_map

        lsp_map("<leader>lr", vim.lsp.buf.rename, bufnr, "Rename symbol")
        lsp_map("<leader>la", vim.lsp.buf.code_action, bufnr, "Code action")
        lsp_map("<leader>lh", vim.lsp.buf.hover, bufnr, "Type definition")
        lsp_map("<leader>ls", require("telescope.builtin").lsp_document_symbols, bufnr, "Document symbols")

        lsp_map("<leader>gd", vim.lsp.buf.definition, bufnr, "Goto Definition")
        lsp_map("<leader>gr", require("telescope.builtin").lsp_references, bufnr, "Goto References")
        lsp_map("<leader>gI", vim.lsp.buf.implementation, bufnr, "Goto Implementation")
        lsp_map("<leader>gD", vim.lsp.buf.declaration, bufnr, "Goto Declaration")

        lsp_map("<leader>F", "<cmd>Format<cr>", bufnr, "Format")

        -- Attach and configure vim-illuminate
        require("illuminate").on_attach(client)
      end

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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
        capabilities = capabilities
      })

      require('lspconfig')["jsonls"].setup {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
          },
        },
      }
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
          }
        }
      })
    end
  }
}
