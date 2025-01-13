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

--- @class AI
local M = {}
M.setup = function(opts)
	require("CopilotChat").setup({})
	setup_codecompanion()
end
return M
