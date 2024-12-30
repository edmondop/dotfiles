local cmp = require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()

local primary_sources = {
		{ name = "nvim_lsp" },
		{ name = "copilot" },
		{ name = "luasnip" }, -- For luasnip users.
	}
local secondary_sources = {
		{ name = "buffer" },
		-- { name = "codeium" },
	}


local setup_base_cmp = function()
	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
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
