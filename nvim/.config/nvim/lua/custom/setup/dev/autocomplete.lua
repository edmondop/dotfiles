-- local cmp = require("cmp")

local blink = require("blink.cmp")
local lspkind = require("lspkind")

-- Load VSCode snippets via LuaSnip
require("luasnip.loaders.from_vscode").lazy_load()

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
			default = { "lsp", "path", "buffer", "copilot", "snippets" },
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					score_offset = 100,
					async = true,
				},
			},
		},
		completion = {},
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
