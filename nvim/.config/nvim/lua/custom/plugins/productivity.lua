return {
	{
		"rmagatti/auto-session",
	},
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"m4xshen/hardtime.nvim",
		lazy = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		-- opts = {},
	},
	{
		"akinsho/toggleterm.nvim",
	},
	{ "echasnovski/mini.diff", version = "*" },
	{
		"stevearc/quicker.nvim",
		event = "FileType qf",
		opts = {},
	},
	{
		"r0nsha/qfpreview.nvim",
	},
}
