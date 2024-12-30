--- @class DataEngineering
local M = {}
M.setup = function(opts)
	require("dbtpal").setup({})
	require("telescope").load_extension("dbtpal")
end
return M
