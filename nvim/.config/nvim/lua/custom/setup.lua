--- @class Setup
local M = {}

M.setup = function(opts)
	opts = opts or {}
	require("custom.setup.dev").setup(opts)
	require("custom.setup.file-browsing").setup(opts)
	require("custom.setup.git").setup(opts)
	require("custom.setup.look-and-feel").setup(opts)
	require("custom.setup.productivity").setup(opts)
	require("custom.setup.snacks").setup(opts)
	require("custom.setup.telescope").setup(opts)
	require("custom.setup.text-editing").setup(opts)
end

return M
