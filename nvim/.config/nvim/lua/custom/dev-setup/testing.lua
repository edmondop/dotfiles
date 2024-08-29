local neotest = require("neotest")

neotest.setup({
	adapters = {
		require("neotest-python")({
			dap = { justMyCode = false },
		}),
		require("neotest-plenary"),
		require("rustaceanvim.neotest"),
	},
	output = { open_on_run = true },
})

vim.keymap.set("n", "<leader>Tn", ":Neotest run<CR>", { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>Td", function()
	neotest.run.run({ strategy = "dap" })
end, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>Tf", ":Neotest run file<CR>", { desc = "Run all tests in a file" })
vim.keymap.set("n", "<leader>Tl", ":Neotest run last<CR>", { desc = "Run last test" })
vim.keymap.set("n", "<leader>Tv", ":Neotest output-panel<CR>", { desc = "Toggle output panel" })
vim.keymap.set("n", "<leader>To", ":Neotest output<CR>", { desc = "Show output" })
vim.keymap.set("n", "<leader>Ts", ":Neotest summary<CR>", { desc = "Neotest summary" })
vim.keymap.set("n", "<leader>Tx", ":Neotest output-panel clear<CR>", { desc = "Clear output panel" })
