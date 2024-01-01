return {
	"stevearc/oil.nvim",
	lazy = false,
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			lsp_rename_autosave = true,
			columns = {
				"permissions",
				"size",
			},
			keymaps = {
				["<leader>e"] = "actions.close",
				["q"] = "actions.close",
			},
		})
	end,
	init = function()
		local mappings = {
			n = {
				["<leader>e"] = { ":lua require('oil').open()<CR>", "open directory browser" },
			},
		}

		require("core.utils").load_mappings(mappings)
	end,
}
