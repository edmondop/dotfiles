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
	{
		"chrisgrieser/nvim-lsp-endhints",
		event = "LspAttach",
		opts = {}, -- required, even if empty
	},
	{
		"Davidyz/inlayhint-filler.nvim",
	},
	{
		"rachartier/tiny-code-action.nvim",
		event = "LspAttach",
	},
}
