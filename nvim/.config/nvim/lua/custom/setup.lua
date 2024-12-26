--- @class Setup
local M = {}

M.setup = function(opts)
	opts = opts or {}
	require("custom.setup.file-browsing").setup(opts)
	require("custom.setup.git").setup(opts)
	require("custom.setup.look-and-feel").setup(opts)
	require("custom.setup.text-editing").setup(opts)
	require("custom.setup.productivity").setup(opts)
end

return M
