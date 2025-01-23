local neotest = require("neotest")
local setup_neotest = function()
	--- @diagnostic disable-next-line
	neotest.setup({
		adapters = {
			require("neotest-python")({
				dap = { justMyCode = false },
			}),
			require("neotest-plenary"),
			require("rustaceanvim.neotest"),
			require("neotest-golang")({
				testify_enabled = true,
			}),
		},
		output = { open_on_run = true, enabled = true },
	})
end

local setup_neotest_keymaps = function()
	vim.keymap.set("n", "<leader>Tn", ":Neotest run<CR>", { desc = "Run nearest test" })
	vim.keymap.set("n", "<leader>Td", function()
		neotest.run.run({ vim.fn.expand("%"), strategy = "dap", suite = false })
	end, { desc = "Run nearest test" })
	vim.keymap.set("n", "<leader>Tf", ":Neotest run file<CR>", { desc = "Run all tests in a file" })
	vim.keymap.set("n", "<leader>Tl", ":Neotest run last<CR>", { desc = "Run last test" })
	vim.keymap.set("n", "<leader>Tv", ":Neotest output-panel<CR>", { desc = "Toggle output panel" })
	vim.keymap.set("n", "<leader>To", ":Neotest output<CR>", { desc = "Show output" })
	vim.keymap.set("n", "<leader>Ts", ":Neotest summary<CR>", { desc = "Neotest summary" })
	vim.keymap.set("n", "<leader>Tx", ":Neotest output-panel clear<CR>", { desc = "Clear output panel" })
end
--- @class Testing
local M = {}
M.setup = function(opts)
	setup_neotest()
	setup_neotest_keymaps()
end
return M
