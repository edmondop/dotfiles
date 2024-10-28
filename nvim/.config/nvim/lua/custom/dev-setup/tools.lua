local tools = {
	{ name = "stylua", capabilities = { "formatting" } },
	{ name = "hclfmt", capabilities = { "formatting" } },
	{ name = "shfmt", capabilities = { "formatting" } },
	{ name = "prettier", capabilities = { "formatting" } },
	{ name = "buf", capabilities = { "formatting", "diagnostics" } },
	{ name = "goimports", capabilities = { "formatting" } },
	{ name = "actionlint", capabilities = { "diagnostics" } },
}

require("mason-tool-installer").setup({
	ensure_installed = vim.tbl_map(function(tool)
		return tool.name
	end, tools),
})

local null_ls = require("null-ls")

local sources = {}
for _, tool in ipairs(tools) do
	for _, capability in ipairs(tool.capabilities) do
		table.insert(sources, null_ls.builtins[capability][tool.name])
	end
end
null_ls.setup({ sources = sources, debug = true })

local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		svelte = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		liquid = { "prettier" },
		lua = { "stylua" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	},
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	})
end, { desc = "Format file or range (in visual mode)" })

require("CopilotChat").setup({})
