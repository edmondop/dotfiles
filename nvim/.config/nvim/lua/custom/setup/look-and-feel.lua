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

local setup_dashboard = function()
	alpha.setup(dashboard.opts)
end

local setup_catppuccin_theme = function()
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
end

local setup_noice = function()
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
end

local setup_statusline = function()
	require("mini.statusline").setup({
		use_icons = true,
	})
end

local setup_notifications = function()
	local notify = require("notify")
	vim.keymap.set("n", "<ESC>", notify.dismiss, { desc = "Dismiss notifications" })
end

--- @class LookAndFeel
local M = {}
M.setup = function(opts)
	opts = opts or {}
	setup_catppuccin_theme()
	setup_dashboard()
	setup_noice()
	setup_notifications()
	setup_statusline()
	-- Improve the default vimui interfaces
	require("dressing").setup(opts)
end

return M