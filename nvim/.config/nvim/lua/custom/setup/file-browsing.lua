--   Oil
local setup_oil = function()
	require("oil").setup({
		default_file_explorer = true,
		delete_to_trash = true,
		view_options = {
			show_hidden = true,
			natural_order = true,
			is_always_hidden = function(name, _)
				return name == ".." or name == ".git"
			end,
		},
		float = {
			padding = 2,
			max_width = 90,
			max_height = 0,
		},
		win_options = {
			wrap = true,
			winblend = 0,
		},
		-- Rebinding closing to "traditional" vim keybindings
		keymaps = {
			["<C-c>"] = false,
			["q"] = "actions.close",
		},
	})
	vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open oil in parent directory" })
end

local setup_neotree = function()
	-- Neotree
	require("neo-tree").setup({
		filesystem = {
			filtered_items = {
				hide_gitignored = false,
				always_show = {
					".gitignored",
					".config",
				},
			},
			follow_current_file = {
				enabled = true,
				leave_dirs_open = false,
			},
		},
		buffers = {
			follow_current_file = {
				enabled = true,
				leave_dirs_open = false,
			},
		},
	})
	vim.keymap.set("n", "<C-n>", "<CMD>Neotree toggle<CR>")
	vim.keymap.set("n", "<leader>nf", "<CMD>Neotree focus<CR>")
end
--- @class FileBrowsing
local M = {}
M.setup = function(opts)
	setup_oil()
	setup_neotree()
end
return M
