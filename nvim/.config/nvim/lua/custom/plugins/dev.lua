return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"williamboman/mason.nvim",
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"neovim/nvim-lspconfig",
	},
	{
		"nvimtools/none-ls.nvim",
	},
	-- Snippets
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/nvim-cmp",
	},
	{
		"github/copilot.vim",
	},
	-- Quickfix and troubles
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
	},
}
