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
	vim.keymap.set("n", "<leader>tn", ":Neotest run<CR>", { desc = "Run nearest test" })
	vim.keymap.set("n", "<leader>td", function()
		neotest.run.run({ vim.fn.expand("%"), strategy = "dap", suite = false })
	end, { desc = "Run nearest test" })
	vim.keymap.set("n", "<leader>tf", ":Neotest run file<CR>", { desc = "Neotest - Run all tests in a file" })
	vim.keymap.set("n", "<leader>tl", ":Neotest run last<CR>", { desc = "Neotest - Run last test" })
	vim.keymap.set("n", "<leader>tv", ":Neotest output-panel<CR>", { desc = "Neotest - Toggle output panel" })
	vim.keymap.set("n", "<leader>to", ":Neotest output<CR>", { desc = "Neotest - Show output" })
	vim.keymap.set("n", "<leader>ts", ":Neotest summary<CR>", { desc = "Neotest - summary" })
	vim.keymap.set("n", "<leader>tx", ":Neotest output-panel clear<CR>", { desc = "Neotest - Clear output panel" })
end
--- @class Testing
local M = {}
M.setup = function(opts)
	setup_neotest()
	setup_neotest_keymaps()
end
return M
