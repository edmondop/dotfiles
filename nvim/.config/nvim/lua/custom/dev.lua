-- Treesitter
local config = require("nvim-treesitter.configs")
config.setup({
	ensure_installed = {
		"bash",
		"css",
		"gitignore",
		"gitattributes",
		"go",
		"gomod",
		"gotmpl",
		"gpg",
		"graphql",
		"hcl",
		"helm",
		"html",
		"lua",
		"json",
		"markdown",
		"proto",
		"python",
		"regex",
		"rust",
		"scala",
		"terraform",
		"tmux",
		"typescript",
	},
	highlight = { enable = true },
	indent = { enable = true },
})
-- Mason
require("mason").setup()

local ensure_installed = {
	"goimports",
	"graphql",
	"hclfmt",
	"jsonls",
	"lua_ls",
	-- "nil_ls", -- This will be conditionally added
	"pyright",
	"ruff",
	"rust_analyzer",
	"sqlls",
	"terraformls",
	"tflint",
	"tsserver",
	"yamlls",
}

-- Check if the environment variable is set
if vim.fn.getenv("ENABLE_NIX") == "1" then
	table.insert(ensure_installed, "nil_ls")
end

require("mason-lspconfig").setup({
	ensure_installed = ensure_installed,
})
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.terraformls.setup({})
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

-- Completions
local cmp = require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
	}, {
		{ name = "buffer" },
	}),
})
-- Null Ls

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.hclfmt,
		null_ls.builtins.formatting.shfmt,
	},
})
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

-- Trouble
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })

vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>cl",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP Definitions / references / ... (Trouble)" }
)

vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", {
	desc = "Quickfix List (Trouble)",
})
