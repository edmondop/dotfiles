-- local cmp = require("cmp")

local blink = require("blink.cmp")
local lspkind = require("lspkind")

-- Load VSCode snippets via LuaSnip
require("luasnip.loaders.from_vscode").lazy_load()
for _, snippet in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
	require(snippet)
end
-- Initialize lspkind with a custom symbol for Copilot
lspkind.init({
	symbol_map = { Copilot = "" },
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
local setup_blink = function()
	blink.setup({
		keymap = {
			preset = "enter",
		},
		sources = {
			default = { "lsp", "copilot", "path", "buffer", "luasnip", "snippets" },
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					score_offset = 100,
					async = true,
					min_keyword_length = 0,
				},
				lsp = { fallbacks = {} },
			},
		},
		completion = {
			documentation = { auto_show = true, auto_show_delay_ms = 300 },
		},
	})
end
local setup_cmd_sql = function()
	-- blink.setup.filetype("sql", {
	-- 	sources = {
	-- 		{ name = "vim-dadbod-completion" },
	-- 		{ name = "buffer" },
	-- 	},
	-- })
end

--- @class Autocomplete
local M = {}
M.setup = function(opts)
	setup_blink()

	setup_cmd_sql()
end
return M
