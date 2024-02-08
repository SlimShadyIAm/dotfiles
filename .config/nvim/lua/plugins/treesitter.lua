-- Highlight, edit, and navigate code
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    build = function()
      pcall(require("nvim-treesitter.install").update({ with_sync = true }))
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-context"
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- add languages to be installed here that you want installed for treesitter
        ensure_installed = { "typescript", "javascript", "java", "lua", "python", "vim", "comment" },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false
        },
        indent = { enable = true, disable = { "python" } },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- you can use the capture groups defined in textobjects.scm
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]m"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[m"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          context_commentstring = {
            enable = true,
            enable_autocmd = false,
          },
        },
      })
      require('nvim-treesitter.configs').setup {
        autotag = {
          enable = true,
        }
      }
      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
          underline = true,
          -- virtual_text = {
          --   spacing = 5,
          --   severity_limit = 'Warning',
          -- },
          update_in_insert = true,
        }
      )
    end,
  },
}
