local lsps = {
	"bashls",
	"graphql",
	"gopls",
	"jdtls",
	"jsonls",
	"lua_ls",
	-- "nil_ls", -- This will be conditionally added
	"pyright",
	"ruff",
	"rust_analyzer",
	"sqlls",
	"terraformls",
	"tflint",
	"ts_ls",
	"yamlls",
}

-- Check if the environment variable is set
if vim.fn.getenv("ENABLE_NIX") == "1" then
	table.insert(lsps, "nil_ls")
end

local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
	-- Code actions
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP - Code Action" })
	vim.keymap.set("v", "<leader>ca", function()
		if vim.lsp.buf.range_code_action then
			vim.lsp.buf.range_code_action()
		else
			vim.lsp.buf.code_action()
		end
	end, { desc = "LSP - Range Code Action" })
	-- Productivity
	vim.keymap.set("n", "<leader>cs", vim.lsp.buf.signature_help, { desc = "LSP - Signature help" })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP - Hover documentation" })
	-- Navigation
	vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "LSP - Go to definition" })
	vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "LSP - Go to declaration" })
	vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, { desc = "LSP - Go to implementation" })
	vim.keymap.set("n", "<leader>ct", vim.lsp.buf.type_definition, { desc = "LSP - Go to type definition" })
	vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, { desc = "LSP - Go to reference" })
	-- Formatting
	vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "LSP - Format file" })
	vim.keymap.set("x", "<leader>cf", vim.lsp.buf.format, { desc = "LSP - Format selection" })
	vim.keymap.set("n", "<space>cn", vim.lsp.buf.rename, { desc = "LSP Rename Symbol" })
	-- Troubles
	vim.keymap.set("n", "<leader>D", "<CMD>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics" })
	vim.keymap.set("n", "<leader>cl", vim.diagnostic.open_float, { desc = "LSP - Show diagnostic" })
	vim.keymap.set("n", "<leader>c[", vim.diagnostic.goto_prev, { desc = "LSP - Previous diagnostic" })
	vim.keymap.set("n", "<leader>c]", vim.diagnostic.goto_next, { desc = "LSP - Next diagnostic" })
end)

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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

require("java").setup()

require("mason-lspconfig").setup({
	ensure_installed = lsps,
	handlers = {
		lsp_zero.default_setup,
		["yamlls"] = function()
			require("lspconfig").yamlls.setup({
				capabilities = capabilities,
			})
		end,
		["rust_analyzer"] = function()
			-- For compatibility with rustaceanvim
		end,
	},
})
