return {
	{
		"williamboman/mason.nvim",
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	{
		"neovim/nvim-lspconfig",
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
	},
	{
		"nvimtools/none-ls.nvim",
	},
	{
		"onsails/lspkind.nvim",
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
}
