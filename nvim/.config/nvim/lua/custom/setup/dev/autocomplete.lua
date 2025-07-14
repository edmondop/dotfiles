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
			["<CR>"] = { "accept_and_enter", "fallback" },
		},
		sources = {
			default = { "lsp", "path", "buffer", "copilot", "snippets" },
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					score_offset = 100,
					async = true,
					min_keyword_length = 0,
				},
			},
		},
		completion = {
			list = {
				selection = {
					preselect = false,
				},
			},
			trigger = {
				show_on_insert = false,
				prefetch_on_insert = true,
				show_on_keyword = true,
				show_on_blocked_trigger_characters = { " ", "\t" },
			},
			ghost_text = {
				enabled = true,
				show_with_menu = true,
				show_without_menu = true,
			},
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
