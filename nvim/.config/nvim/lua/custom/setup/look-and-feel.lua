local alpha = require("alpha")
local dashboard = require("alpha.themes.startify")
local aisetup = require("custom.setup.dev.ai")

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
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = false,
			lsp_doc_border = false,
		},
	})
end

local setup_statusline = function()
	local mini_statusline = require("mini.statusline")
	mini_statusline.setup({
		use_icons = true,
		content = {
			active = function()
				local mode, mode_hl = mini_statusline.section_mode({ trunc_width = 120 })
				local git = mini_statusline.section_git({ trunc_width = 40 })
				local diff = mini_statusline.section_diff({ trunc_width = 75 })
				local diagnostics = mini_statusline.section_diagnostics({ trunc_width = 75 })
				local lsp = mini_statusline.section_lsp({ trunc_width = 75 })
				local filename = mini_statusline.section_filename({ trunc_width = 140 })
				local fileinfo = mini_statusline.section_fileinfo({ trunc_width = 120 })
				local location = mini_statusline.section_location({ trunc_width = 75 })
				local search = mini_statusline.section_searchcount({ trunc_width = 75 })

				local codecompanion = aisetup.codecompanion_status()
				local copilot = aisetup.copilot_status()
				return mini_statusline.combine_groups({
					{ hl = mode_hl, strings = { mode } },
					{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
					"%<", -- Mark general truncate point
					{ hl = "MiniStatuslineFilename", strings = { filename } },
					"%=", -- End left alignment
					{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
					{ hl = "MiniStatuslineFilename", strings = { codecompanion } }, -- Add the spinner here
					{ hl = "MiniStatuslineFilename", strings = { copilot } }, -- Add the spinner here
					{ hl = mode_hl, strings = { search, location } },
				})
			end,
		},
	})
end

local setup_notifications = function()
	local notify = require("notify")
	vim.keymap.set("n", "<ESC>", notify.dismiss, { desc = "Dismiss notifications" })
	notify.setup({
		log_level = vim.log.levels.DEBUG,
		background_colour = "#000000",
	})
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
