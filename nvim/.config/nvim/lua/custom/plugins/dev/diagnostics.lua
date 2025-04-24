return {
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = {},
		-- specs = {
		-- 	"folke/snacks.nvim",
		-- 	opts = function(_, opts)
		-- 		return vim.tbl_deep_extend("force", opts or {}, {
		-- 			picker = {
		-- 				actions = require("trouble.sources.snacks").actions,
		-- 				win = {
		-- 					input = {
		-- 						keys = {
		-- 							["<c-t>"] = {
		-- 								"trouble_open",
		-- 								mode = { "n", "i" },
		-- 							},
		-- 						},
		-- 					},
		-- 				},
		-- 			},
		-- 		})
		-- 	end,
		-- },
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("tiny-inline-diagnostic").setup()
			vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
		end,
	},
}
