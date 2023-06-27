return {
  {
    "ThePrimeagen/harpoon",
    event = "VimEnter",
    config = function()
      require("harpoon").setup({
        global_settings = {
          save_on_toggle = true,
          save_on_change = true,
        },
      })
      local map = require("helpers.keys").map
      local ui = require("harpoon.ui")
      local mark = require("harpoon.mark")

      map("n", "<leader>a", mark.add_file, "Add file to Harpoon")
      map("n", "<leader><leader>", ui.toggle_quick_menu, "Reveal Harpoon quick menu")

      map("n", "<C-z>", function() ui.nav_file(1) end, "Navigate to file 1")
      map("n", "<C-x>", function() ui.nav_file(2) end, "Navigate to file 2")
      map("n", "<C-c>", function() ui.nav_file(3) end, "Navigate to file 3")
      map("n", "<C-v>", function() ui.nav_file(4) end, "Navigate to file 4")
    end,
  }
}
