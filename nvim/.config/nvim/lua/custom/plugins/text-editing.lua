return {
	{
		"echasnovski/mini.surround",
		version = false,
	},

	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
	},
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
		},
	},
	{
		"gbprod/substitute.nvim",
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"kylechui/nvim-surround",
		event = { "BufReadPre", "BufNewFile" },
	},
	{ "sindrets/diffview.nvim" },
	{
		"folke/zen-mode.nvim",
	},
	{
		"folke/twilight.nvim",
	},
	{
		"reedes/vim-pencil",
	},
	{ "echasnovski/mini.cursorword", version = "*" },
}
