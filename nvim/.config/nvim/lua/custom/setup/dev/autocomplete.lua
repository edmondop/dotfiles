local cmp = require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()

local primary_sources = {
	{ name = "nvim_lsp" },
	{ name = "copilot" },
	{ name = "luasnip" }, -- For luasnip users.
	{ name = "codecompanion" },
}
local secondary_sources = {
	{ name = "buffer" },
	-- { name = "codeium" },
}
local setup_base_cmp = function()
	local lspkind = require("lspkind")
	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},

		--- @diagnostic disable-next-line
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				max_width = {
					menu = 50,
					abbr = 30,
				},
				ellipsis_char = "...",
				show_labelDetails = true,
				menu = {
					buffer = "[Buffer]",
					nvim_lsp = "[LSP]",
					luasnip = "[LuaSnip]",
					nvim_lua = "[Lua]",
					latex_symbols = "[Latex]",
				},
				before = function(entry, vim_item)
					return vim_item
				end,
			}),
		},
		window = {
			completion = {
				border = "rounded",
				col_offset = 0,
				side_padding = 1,
			},
			documentation = { border = "rounded", max_width = 50, max_height = 30 },
		},
		mapping = cmp.mapping.preset.insert({
			["<C-p>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
		}),
		sources = cmp.config.sources(primary_sources, secondary_sources),
	})
end
local setup_cmdline_extension = function()
	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	-- `:` cmdline setup.
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{
				name = "cmdline",
				option = {
					ignore_cmds = { "Man", "!" },
				},
			},
		}),
	})
end

--- @class Autocomplete
local M = {}
M.setup = function(opts)
	setup_base_cmp()
	setup_cmdline_extension()
end
return M
