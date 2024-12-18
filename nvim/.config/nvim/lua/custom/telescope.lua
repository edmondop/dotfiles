-- Telescope key builtins
local telescope = require("telescope")
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find files" })
vim.keymap.set(
	"n",
	"<leader>fg",
	":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
	{ desc = "Find - Live Grep" }
)
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help Tags" })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find Old Files" })
vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Word under Cursor" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
local lga_actions = require("telescope-live-grep-args.actions")
telescope.setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
			"--glob",
			"!.git/*",
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
		undo = {},
		live_grep_args = {
			auto_quoting = true,
			["<C-k>"] = lga_actions.quote_prompt(),
			["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
			-- freeze the current list and start a fuzzy search in the frozen list
			["<C-space>"] = lga_actions.to_fuzzy_refine,
		},
	},
})

telescope.load_extension("live_grep_args")
telescope.load_extension("ui-select")
telescope.load_extension("undo")
telescope.load_extension("noice")
telescope.load_extension("harpoon")
-- Telescope extensions
vim.keymap.set("n", "<leader>u", "<CMD>Telescope undo<cr>")
vim.keymap.set("n", "<leader>r", "<CMD>Telescope neoclip star<cr>")
