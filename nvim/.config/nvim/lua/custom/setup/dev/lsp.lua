local lsps = {
	"bashls",
	-- cannot be installed as lsp?
	-- "bacon",
	-- "bacon_ls",
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
	vim.table.insert("force", lsps, "nil_ls")
end

local lsp_zero = require("lsp-zero")

local setup_lsp_keymaps = function()
	lsp_zero.on_attach(function(client, bufnr)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP - Code Action", buffer = bufnr })
		vim.keymap.set("v", "<leader>ca", function()
			if vim.lsp.buf.range_code_action then
				vim.lsp.buf.range_code_action()
			else
				vim.lsp.buf.code_action()
			end
		end, { desc = "LSP - Range Code Action", buffer = bufnr })
		-- Productivity
		vim.keymap.set("n", "<leader>cs", vim.lsp.buf.signature_help, { desc = "LSP - Signature help", buffer = bufnr })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP - Hover documentation" })
		-- Navigation
		vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "LSP - Go to definition", buffer = bufnr })
		vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "LSP - Go to declaration", buffer = bufnr })
		vim.keymap.set(
			"n",
			"<leader>ci",
			vim.lsp.buf.implementation,
			{ desc = "LSP - Go to implementation", buffer = bufnr }
		)
		vim.keymap.set(
			"n",
			"<leader>ct",
			vim.lsp.buf.type_definition,
			{ desc = "LSP - Go to type definition", buffer = bufnr }
		)
		vim.keymap.set("n", "<leader>cr", vim.lsp.buf.references, { desc = "LSP - Go to reference", buffer = bufnr })
		-- Formatting
		vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "LSP - Format file", buffer = bufnr })
		vim.keymap.set("x", "<leader>cf", vim.lsp.buf.format, { desc = "LSP - Format selection", buffer = bufnr })
		vim.keymap.set("n", "<space>cn", vim.lsp.buf.rename, { desc = "LSP Rename Symbol", buffer = bufnr })
	end)
end

local setup_lsp_capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}
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
end

local tools = {
	{ name = "stylua", capabilities = { "formatting" } },
	{ name = "hclfmt", capabilities = { "formatting" } },
	{ name = "shfmt", capabilities = { "formatting" } },
	{ name = "prettier", capabilities = { "formatting" } },
	{ name = "buf", capabilities = { "formatting", "diagnostics" } },
	{ name = "goimports", capabilities = { "formatting" } },
	{ name = "actionlint", capabilities = { "diagnostics" } },
}

local setup_non_lsp_sources = function()
	require("mason-tool-installer").setup({
		ensure_installed = vim.tbl_map(function(tool)
			return tool.name
		end, tools),
	})

	local null_ls = require("null-ls")

	local sources = {}
	for _, tool in ipairs(tools) do
		for _, capability in ipairs(tool.capabilities) do
			vim.tbl_extend("force", sources, null_ls.builtins[capability][tool.name])
		end
	end
	null_ls.setup({ sources = sources, debug = true })
end

--- @class LSP
local M = {}
M.setup = function(opts)
	-- Orphan java, didn't know where to put it
	require("java").setup()
	setup_lsp_keymaps()
	setup_non_lsp_sources()
	setup_lsp_capabilities()
end
return M
