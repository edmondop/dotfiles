return {
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		lazy = false,
	},
	{ "mfussenegger/nvim-dap-python" },
	{ "nvim-java/nvim-java" },
	{
		"PedramNavid/dbtpal",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		ft = {
			"sql",
			"md",
			"yaml",
		},
	},
}
