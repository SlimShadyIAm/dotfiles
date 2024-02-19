local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
local servers = { "pylsp", "tailwindcss", "pyright", "jsonls", "eslint", "lua_ls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.typescript.setup {
  on_attach = function(client, bufnr)
    local lsp_map = require("helpers.keys").lsp_map
    on_attach(client, bufnr)
    lsp_map("<leader>F", "<cmd>Format<cr><cmd>EslintFixAll<cr>", bufnr, "Format")
  end,
}
