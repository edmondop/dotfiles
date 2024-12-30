local setup_trouble = function()
	vim.keymap.set("n", "<leader>TX", "<CMD>Trouble diagnostics toggle<cr>", { desc = "Trouble - Diagnostics" })

	vim.keymap.set(
		"n",
		"<leader>TB",
		"<CMD>Trouble diagnostics toggle filter.buf=0<cr>",
		{ desc = "Buffer Diagnostics (Trouble)" }
	)

	vim.keymap.set("n", "<leader>TS", "<CMD>Trouble symbols toggle focus=false<cr>", { desc = "Trouble - Symmbols" })

	vim.keymap.set(
		"n",
		"<leader>TR",
		"<CMD>Trouble lsp toggle focus=false win.position=right<cr>",
		{ desc = "Trouble - LSP Definitions / references / ... (Trouble)" }
	)

	vim.keymap.set("n", "<leader>TL", "<CMD>Trouble loclist toggle<cr>", { desc = "Location List" })

	vim.keymap.set("n", "<leader>TQ", "<CMD>Trouble qflist toggle<cr>", {
		desc = "Trouble - Quickfix List",
	})
end

local setup_vim_diagnostics_keymaps = function()
	vim.keymap.set("n", "<leader>cl", vim.diagnostic.open_float, { desc = "LSP - Show diagnostic" })
	vim.keymap.set("n", "<leader>c[", vim.diagnostic.goto_prev, { desc = "LSP - Previous diagnostic" })
	vim.keymap.set("n", "<leader>c]", vim.diagnostic.goto_next, { desc = "LSP - Next diagnostic" })
end

local setup_telescope_diagnostics_keymaps = function()
	vim.keymap.set("n", "<leader>D", "<CMD>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics" })
end
--- @class Diagnostics
local M = {}
M.setup = function(opts)
	setup_telescope_diagnostics_keymaps()
	setup_trouble()
	setup_vim_diagnostics_keymaps()
end
return M
