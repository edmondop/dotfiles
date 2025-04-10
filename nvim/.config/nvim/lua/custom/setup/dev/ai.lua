local setup_codecompanion = function()
	require("codecompanion").setup({
		strategies = {
			chat = {
				adapter = "copilot",
			},
			inline = {
				adapter = "copilot",
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

function setup_copilot()
	require("copilot").setup({
		-- suggestions = { enabled = false },
		-- panel = { enabled = false },
		filetypes = {
			yaml = true,
		},
	})
	require("copilot_cmp").setup({})
end

--- @class AI
local M = {}
M.setup = function(opts)
	setup_copilot({})
	require("CopilotChat").setup({})
	setup_codecompanion()
end
M.codecompanion_status = function()
	return update_spinner()
end

M.copilot_status = function()
	local ok, copilot_status = pcall(require, "copilot_status")
	if not ok then
		return "Copilot Status not available"
	end
	return copilot_status.status_string()
end
return M
