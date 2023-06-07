-- Nicer filetree than NetRW
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
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
          indent = { padding = 0, indent_size = 1 },
          icon = {
            folder_empty = "󰜌",
            folder_empty_open = "󰜌",
          },
          git_status = {
            symbols = {
              renamed  = "󰁕",
              unstaged = "󰄱",
            },
          },
        },
        window = {
          width = 30,
        },
        filesystem = {
          follow_current_file = true,
          hijack_netrw_behavior = "open_current",
          use_libuv_file_watcher = true,
        },
        event_handlers = {
          {
            event = "neo_tree_buffer_enter",
            handler = function(_) vim.opt_local.signcolumn = "auto" end,
          },
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

      map({ "n", "v" }, "<leader>he", "<cmd>NeoTreeRevealToggle<cr>", "Toggle file explorer")
      map({ "n", "v" }, "<leader>e", "<C-w>t", "Focus file explorer")
      map({ "n", "v" }, "<leader>c", "<C-w>l", "Focus code")
      map({ "n", "v" }, "<leader>re", "<cmd>Neotree reveal<cr>", "Reveal file in explorer")
      vim.api.nvim_create_autocmd("VimEnter", {
        command = "set nornu nonu | Neotree toggle",
      })
    end,
  },
}
