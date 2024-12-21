return {
	-- {
	-- 	"saghen/blink.cmp",
	-- 	-- optional: provides snippets for the snippet source
	-- 	dependencies = "rafamadriz/friendly-snippets",
	-- },
	-- {
	--
	-- 	"giuxtaposition/blink-cmp-copilot",
	-- },
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
	{ "rafamadriz/friendly-snippets" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "saadparwaiz1/cmp_luasnip" },
}
