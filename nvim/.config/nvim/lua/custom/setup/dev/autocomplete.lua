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
		keymap = { preset = "enter" },
	})
	-- 	snippet = {
	-- 		expand = function(args)
	-- 			require("luasnip").lsp_expand(args.body)
	-- 		end,
	-- 	},
	-- 	formatting = {
	-- 		format = lspkind.cmp_format({
	-- 			mode = "symbol_text",
	-- 			max_width = 50,
	-- 			ellipsis_char = "...",
	-- 			menu = {
	-- 				copilot = "[Copilot]",
	-- 				buffer = "[Buffer]",
	-- 				lsp = "[LSP]",
	-- 				snippets = "[LuaSnip]",
	-- 				nvim_lua = "[Lua]",
	-- 				latex_symbols = "[Latex]",
	-- 			},
	-- 		}),
	-- 	},
	-- 	-- mapping = blink.mapping.preset.insert(), -- use Blink’s default insert mappings
	-- 	sources = {
	-- 		{ name = "lsp" },
	-- 		{ name = "copilot" },
	-- 		{ name = "snippets" },
	-- 		{ name = "codecompanion" },
	-- 		{ name = "buffer" },
	-- 	},
	-- })
end

local setup_cmdline_extension = function()
	-- Setup for searching ("/") and command-line (":")
	-- blink.setup.cmdline("/", {
	-- 	mapping = blink.mapping.preset.cmdline(),
	-- 	sources = { { name = "buffer" } },
	-- })
	--
	-- blink.setup.cmdline(":", {
	-- 	mapping = blink.mapping.preset.cmdline(),
	-- 	sources = {
	-- 		{ name = "path" },
	-- 		{ name = "cmdline", option = { ignore_cmds = { "Man", "!" } } },
	-- 	},
	-- })
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
	setup_cmdline_extension()

	setup_cmd_sql()
end
return M
