return {
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		lazy = false,
	},
	{ "mfussenegger/nvim-dap-python" },
	{
		"alexpasmantier/pymple.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			-- optional (nicer ui)
			"stevearc/dressing.nvim",
		},
		build = "PympleBuild",
	},
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
