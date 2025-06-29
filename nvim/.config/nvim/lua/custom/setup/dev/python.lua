local setup_pymple = function()
	require("pymple").setup()
end

local setup_dap_python = function()
	require("dap-python").setup()
end

--- @class Python
local M = {}
M.setup = function()
	setup_pymple()
	setup_dap_python()
end
return M
