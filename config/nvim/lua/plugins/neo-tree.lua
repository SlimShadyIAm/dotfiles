-- Nicer filetree than NetRW
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    event = "VeryLazy",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

      require("neo-tree").setup({
        auto_clean_after_session_restore = true,
        close_if_last_window = true,
        sources = { "filesystem", "buffers", "git_status" },
        follow_current_file = true,
        buffers = {
          follow_current_file = true, -- This will find and focus the file in the active buffer every
          -- time the current file is changed while the tree is open.
          group_empty_dirs = true,
        },
        default_component_configs = {
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
            default = ""
          },
          git_status = {
            symbols = {
              added = "",
              modified = "",
              deleted = "",
              renamed = "➜",
              untracked = "",
              ignored = "",
              unstaged = "",
              staged = "✓",
              conflict = ""
            }
          },
        },
        window = {
          position = "right",
          width = 30,
        },
        filesystem = {
          follow_current_file = true,
          hijack_netrw_behavior = "open_current",
          use_libuv_file_watcher = true,
          components = {
            harpoon_index = function(config, node, state)
              local Marked = require("harpoon.mark")
              local path = node:get_id()
              local succuss, index = pcall(Marked.get_index_of, path)
              if succuss and index and index > 0 then
                return {
                  text = string.format("󰁃 %d", index),
                  highlight = config.highlight or "NeoTreeDirectoryIcon",
                }
              else
                return {}
              end
            end
          },
          renderers = {
            file = {
              { "icon" },
              { "name",         use_git_status_colors = true },
              { "harpoon_index" },
              { "diagnostics" },
              { "git_status",   highlight = "NeoTreeDimText" },
            }
          }
        },
        event_handlers = {
          {
            event = "neo_tree_buffer_enter",
            handler = function(_) vim.opt_local.signcolumn = "auto" end,
          },
          {
            event = "file_opened",
            handler = function(_state)
              require("neo-tree").close_all()
            end
          },
          {
            event = "neo_tree_window_after_open",
            handler = function(args)
              if args.position == "left" or args.position == "right" then
                vim.cmd("wincmd =")
              end
            end
          },
          {
            event = "neo_tree_window_after_close",
            handler = function(args)
              if args.position == "left" or args.position == "right" then
                vim.cmd("wincmd =")
              end
            end
          }
        },
        document_symbols = {
          kinds = {
            File = { icon = "󰈙", hl = "Tag" },
            Namespace = { icon = "󰌗", hl = "Include" },
            Package = { icon = "󰏖", hl = "Label" },
            Class = { icon = "󰌗", hl = "Include" },
            Property = { icon = "󰆧", hl = "@property" },
            Enum = { icon = "󰒻", hl = "@number" },
            Function = { icon = "󰊕", hl = "Function" },
            String = { icon = "󰀬", hl = "String" },
            Number = { icon = "󰎠", hl = "Number" },
            Array = { icon = "󰅪", hl = "Type" },
            Object = { icon = "󰅩", hl = "Type" },
            Key = { icon = "󰌋", hl = "" },
            Struct = { icon = "󰌗", hl = "Type" },
            Operator = { icon = "󰆕", hl = "Operator" },
            TypeParameter = { icon = "󰊄", hl = "Type" },
            StaticMethod = { icon = '󰠄 ', hl = 'Function' },
          }
        },
      })
      local map = require("helpers.keys").map

      map({ "n", "v" }, "<leader>e", "<cmd>NeoTreeRevealToggle<cr>", "Toggle file explorer")
    end,
  },
}
