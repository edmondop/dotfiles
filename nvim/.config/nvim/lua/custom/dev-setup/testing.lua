local neotest = require("neotest")

neotest.setup({
	adapters = {
		require("neotest-python")({
			dap = { justMyCode = false },
		}),
		require("neotest-plenary"),
		require("rustaceanvim.neotest"),
	},
})

vim.keymap.set("n", "<leader>Tn", ":Neotest run<CR>", { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>Tn", function()
	neotest.run.run({ strategy = "dap" })
end, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>Tf", ":Neotest run file<CR>", { desc = "Run all tests in a file" })
vim.keymap.set("n", "<leader>Tl", ":Neotest run last<CR>", { desc = "Run last test" })
vim.keymap.set("n", "<leader>Tv", ":Neotest output-panel<CR>", { desc = "Toggle output panel" })
