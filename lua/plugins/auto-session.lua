local function close_neo_tree()
	require 'neo-tree.sources.manager'.close_all()
	vim.notify('closed all')
end

local function open_neo_tree()
	vim.notify('opening neotree')
	require 'neo-tree.sources.manager'.show('filesystem')
end

return {
	{
		"rmagatti/auto-session",
		config = function()
			local autosession = require("auto-session")
			autosession.setup({
				pre_save_cmds = {
					close_neo_tree,
				},
				post_restore_cmds = {
					open_neo_tree,
				}
			})
		end,
	},
}
