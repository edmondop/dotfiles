-- Oil
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
	keymaps = {
		["<C-c>"] = false,
		["q"] = "actions.close",
	},
})
vim.keymap.set("n", "-","<CMD>Oil<CR>", { desc = "Open oil in parent directory" })
-- Neotree
vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>")
-- Windows Management
vim.o.winwidth = 10
vim.o.winminwidth = 10
vim.o.equalalways = false
require("windows").setup()
-- Tmux
require("nvim-tmux-navigation").setup({})
vim.keymap.set("n", "<C-h>", "<CMD>NvimTmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-j>", "<CMD>NvimTmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<CMD>NvimTmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-l>", "<CMD>NvimTmuxNavigateRight<CR>")

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
