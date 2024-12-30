local setup_avante = function()
	require("avante").setup({
		provider = "copilot",
	})
end

--- @class AI
local M = {}
M.setup = function(opts)
	require("CopilotChat").setup({})
	setup_avante()
end
return M
