-- Ufo
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
vim.keymap.set("n", "zK", function()
	local winid = require("ufo").peekFoldedLinesUnderCursor()
	if not winid then
		vim.lsp.buf.hover()
	end
end, { desc = "Peek Fold" })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
	require("lspconfig")[ls].setup({
		capabilities = capabilities,
		-- you can add other fields for setting up lsp server in this table
	})
end
require("ufo").setup({})

require("neoclip").setup()

local substitute = require("substitute")
substitute.setup()
vim.keymap.set("n", "S", substitute.operator, { desc = "Substitute with motion" })
vim.keymap.set("n", "SS", substitute.line, { desc = "Substitute line" })
-- vim.keymap.set("n", "S", substitute.eol, { desc = "Substitute to end of line" })
vim.keymap.set("x", "S", substitute.visual, { desc = "Substitute in visual mode" })
local substitute_range = require("substitute.range")
vim.keymap.set("n", "<leader>S", substitute_range.operator, { desc = "Substitute range" })
vim.keymap.set("x", "<leader>S", substitute_range.visual, { desc = "Substitute range" })
vim.keymap.set("n", "<leader>SS", substitute_range.word, { desc = "Substitute range in current word" })

require("mini.surround").setup({})

require("zen-mode").setup({})
require("twilight").setup({})

vim.keymap.set("n", "<leader>zz", "<CMD>Zenmode<CR>", { desc = "Zenmode" })
vim.keymap.set("n", "<leader>zT", "<CMD>Twilight<CR>", { desc = "Twilight" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "tex", "text" },
	callback = function()
		vim.fn["pencil#init"]()
	end,
})

require("mini.cursorword").setup()
