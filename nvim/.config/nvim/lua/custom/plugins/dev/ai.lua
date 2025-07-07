return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
	},
	{
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
	},
	{
		"jonahgoldwastaken/copilot-status.nvim",
		dependencies = { "zbirenbaum/copilot.lua" },
		event = "BufReadPost",
	},
	-- {
	-- 	"Exafunction/codeium.vim",
	-- 	event = "BufEnter",
	-- },
	--
	-- {
	-- 	"Davidyz/VectorCode",
	-- 	version = "*",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- },
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"ravitemer/codecompanion-history.nvim",
		},
		config = true,
	},
	{
		"augmentcode/augment.vim",
	},
}
