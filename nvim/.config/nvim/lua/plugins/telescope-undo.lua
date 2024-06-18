return {
	"debugloop/telescope-undo.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	config = function()
		local opts = {
			extension = {
				undo = {},
			},
		}
		require("telescope").setup(opts)
		require("telescope").load_extension("undo")
		vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
	end,
}
