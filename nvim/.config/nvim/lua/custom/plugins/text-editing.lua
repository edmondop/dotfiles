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
			{ "kkharji/sqlite.lua", module = "sqlite" },
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
	{
		"epwalsh/obsidian.nvim",
		event = {
			-- Lazy-load obsidian.nvim only for Markdown files in your vault
			"BufReadPre "
				.. vim.fn.expand("~/Documents/PersonalKnowledge")
				.. "/*.md",
			"BufNewFile " .. vim.fn.expand("~/Documents/PersonalKnowledge") .. "/*.md",
		},
		-- {
		-- 	"3rd/image.nvim",
		-- 	build = false,
		-- },
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
	},
	{
		"jake-stewart/multicursor.nvim",
		branch = "1.0",
	},
}
