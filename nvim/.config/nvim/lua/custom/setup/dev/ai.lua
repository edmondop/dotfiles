local setup_codecompanion = function()
	-- require("vectorcode").setup({})
	require("codecompanion").setup({
		display = {
			diff = {
				provider = "minidiff",
			},
		},
		strategies = {
			chat = {
				adapter = {
					name = "copilot",
					model = "claude-sonnet-4",
				},
				keymaps = {
					close = {
						modes = {},
					},
					toggle = {
						modes = {
							n = "<C-c>",
							i = "<C-c>",
						},
						callback = function()
							vim.cmd("CodeCompanionChat Toggle")
						end,
						description = "Toggle Chat",
					},
				},
			},
			inline = {
				adapter = {
					name = "copilot",
					model = "claude-sonnet-4",
				},
			},
		},
		extensions = {
			history = {
				enabled = true,
				opts = {
					keymap = "gh",
					save_chat_keymap = "sc",
					auto_save = true,
					expiration_days = 0,
					picker = "snacks", --- ("telescope", "snacks", "fzf-lua", or "default")
					auto_generate_title = true,
					title_generation_opts = {
						---Adapter for generating titles (defaults to current chat adapter)
						adapter = "copilot", -- "copilot"
						---Model for generating titles (defaults to current chat model)
						model = nil, -- "gpt-4o"
					},
					---On exiting and entering neovim, loads the last chat on opening chat
					continue_last_chat = false,
					---When chat is cleared with `gx` delete the chat from history
					delete_on_clearing_chat = false,
					dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
					---Enable detailed logging for history extension
					enable_logging = false,
				},
			},
		},
	})
end

local spinner_symbols = {
	"⠋",
	"⠙",
	"⠹",
	"⠸",
	"⠼",
	"⠴",
	"⠦",
	"⠧",
	"⠇",
	"⠏",
}
local spinner_symbols_len = 10

local processing = false
local spinner_index = 1

-- Function to update the spinner
local function update_spinner()
	if processing then
		spinner_index = (spinner_index % spinner_symbols_len) + 1
		return spinner_symbols[spinner_index]
	else
		return ""
	end
end

local function force_statusline_redraw()
	if processing then
		vim.api.nvim_command("redrawstatus") -- Force redraw the statusline
		vim.defer_fn(force_statusline_redraw, 100) -- Redraw every 100ms
	end
end

-- Autocommand to handle CodeCompanion events
vim.api.nvim_create_augroup("CodeCompanionHooks", {})
vim.api.nvim_create_autocmd({ "User" }, {
	pattern = "CodeCompanionRequest*",
	group = "CodeCompanionHooks",
	callback = function(request)
		if request.match == "CodeCompanionRequestStarted" then
			processing = true
			force_statusline_redraw()
		elseif request.match == "CodeCompanionRequestFinished" then
			processing = false
		end
	end,
})

local function setup_copilot()
	require("copilot").setup({
		suggestion = { enabled = true, auto_trigger = true, keymap = { accept = "<TAB>" } },
		copilot_model = "claude-sonnet-4",
		filetypes = {
			yaml = true,
		},
	})

	-- require("copilot_cmp").setup({})
end

--- @class AI
local M = {}
M.setup = function(opts)
	setup_copilot()
	setup_codecompanion()
end
M.codecompanion_status = function()
	return update_spinner()
end
local icons = {
	idle = " ",
	error = " ",
	offline = " ",
	warning = " ",
	loading = " ",
}
M.copilot_status = function()
	if not package.loaded["copilot"] then
		return icons.offline
	end

	local status = require("copilot.status")

	local data = status.data

	-- 3. Map LSP status ➜ your glyphs
	if data.status == "InProgress" then -- actively fetching
		return icons.loading .. (data.message or "")
	elseif data.status == "Normal" or data.status == "" then
		return icons.idle .. (data.message or "")
	elseif data.status == "Warning" or data.status == "Error" then
		return icons.warn .. (data.message or "")
	else
		return icons.offline
	end
	-- -- local ok, copilot_status = pcall(require, "copilot_status")
	-- -- if not ok then
	-- -- 	return "Copilot Status not available"
	-- -- end
	-- -- return copilot_status.status_string()
	-- local agent = vim.g.loaded_copilot == 1 and vim.fn["copilot#RunningClient"]() or nil
	-- if agent == nil then
	-- 	return icons.offline
	-- end
	-- -- most of the time, requests is just empty dict.
	-- if type(agent) == "table" then
	-- 	local requests = agent.requests or {}
	--
	-- 	-- requests is dict with number as index, get status from those requests.
	-- 	for _, req in pairs(requests) do
	-- 		local req_status = req.status
	-- 		if req_status == "running" then
	-- 			return icons.idle
	-- 		end
	-- 	end
	-- 	return icons.loading
	-- end
end
return M
