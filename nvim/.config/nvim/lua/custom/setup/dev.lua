--- @class Development
local M = {}
M.setup = function(opts)
	require("custom.setup.dev.ai").setup(opts)
	require("custom.setup.dev.autocomplete").setup(opts)
	require("custom.setup.dev.dataeng").setup(opts)
	require("custom.setup.dev.debugging").setup(opts)
	require("custom.setup.dev.diagnostics").setup(opts)
	require("custom.setup.dev.formatting").setup(opts)
	require("custom.setup.dev.lsp").setup(opts)
	require("custom.setup.dev.productivity").setup(opts)
	require("custom.setup.dev.rust").setup(opts)
	require("custom.setup.dev.testing").setup(opts)
	require("custom.setup.dev.treesitter").setup(opts)
end
return M
