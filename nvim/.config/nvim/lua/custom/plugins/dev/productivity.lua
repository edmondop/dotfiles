return {
	{
		"stevearc/aerial.nvim",
		opts = {},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"numToStr/comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		main = "ibl",
	},
	{
		"ribelo/taskwarrior.nvim",
	},
	{
		"oysandvik94/curl.nvim",
		cmd = { "CurlOpen" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = true,
	},
}
