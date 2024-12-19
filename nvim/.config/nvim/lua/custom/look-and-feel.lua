-- Alpha / Dashboard

local alpha = require("alpha")
local dashboard = require("alpha.themes.startify")

dashboard.section.header.val = {
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                     ]],
	[[       ████ ██████           █████      ██                     ]],
	[[      ███████████             █████                             ]],
	[[      █████████ ███████████████████ ███   ███████████   ]],
	[[     █████████  ███    █████████████ █████ ██████████████   ]],
	[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
	[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
	[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
}

alpha.setup(dashboard.opts)
-- Catppuccin
require("catppuccin").setup({
	flavour = "mocha",
	color_overrides = {
		mocha = {
			base = "#13131c",
			mantle = "#11111b",
			crust = "#000000",
		},
	},
	integrations = {
		telescope = {
			enabled = true,
		},
		dropbar = {
			enabled = true,
			color_mode = true,
		},
	},
})
vim.cmd.colorscheme("catppuccin")
require("noice").setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	},
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
})

-- Status Line
-- require("lualine").setup({
-- 	theme = "auto",
-- 	sections = {
-- 		lualine_c = {
-- 			{
-- 				"filename",
-- 				path = 1,
-- 			},
-- 		},
-- 		lualine_x = {
-- 			{
-- 				require("noice").api.status.message.get_hl,
-- 				cond = require("noice").api.status.message.has,
-- 			},
-- 			{
-- 				require("noice").api.status.command.get,
-- 				cond = require("noice").api.status.command.has,
-- 				color = { fg = "#ff9e64" },
-- 			},
-- 			{
-- 				require("noice").api.status.mode.get,
-- 				cond = require("noice").api.status.mode.has,
-- 				color = { fg = "#ff9e64" },
-- 			},
-- 			{
-- 				require("noice").api.status.search.get,
-- 				cond = require("noice").api.status.search.has,
-- 				color = { fg = "#ff9e64" },
-- 			},
-- 		},
-- 	},
-- })
--
require("mini.statusline").setup({
	use_icons = true,
})
local notify = require("notify")
vim.keymap.set("n", "<ESC>", notify.dismiss, { desc = "Dismiss notifications" })

require("dressing").setup({})
