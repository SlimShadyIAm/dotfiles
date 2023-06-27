-- Telescope fuzzy finding (all the things)
return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
        pickers = {
          buffers = {
            sort_lastused = true
          }
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            }
          }
        }
      })

      -- Enable telescope fzf native, if installed
      pcall(require("telescope").load_extension, "fzf")
      require("telescope").load_extension("ui-select")
      local map = require("helpers.keys").map
      -- map("n", "<leader>fr", require("telescope.builtin").oldfiles, "Recently opened")
      -- map("n", "<leader><space>", require("telescope.builtin").buffers, "Open buffers")
      map("n", "<leader>/", function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, "Search in current buffer")
      require('telescope.actions')
      map("n", "<leader>ff", require("telescope.builtin").find_files, "Find files")
      map("n", "<leader>fh", require("telescope.builtin").help_tags, "Help")
      -- map("n", "<leader>fw", require("telescope.builtin").grep_string, "Current word")
      map("n", "<leader>fw", require("telescope.builtin").live_grep, "Grep")

      map("n", "<leader>fk", require("telescope.builtin").keymaps, "Search keymaps")
    end,
  },
	{
		"nvim-telescope/telescope-ui-select.nvim",
    event = "VimEnter"
	},
}
