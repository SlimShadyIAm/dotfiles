return {
    {
        "RRethy/vim-illuminate",
        event = "BufRead",
        config = function()
            local illuminate = require("illuminate")
            illuminate.configure()
            local map = require("helpers.keys").map
            map("n", "<C-n>", '<a-n>', "Next occurrence")
            map("n", "<C-m>", '<a-p>', "Previous occurrence")
        end,
    },
}
