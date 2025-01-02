--- @class DataEngineering
local M = {}
M.setup = function(opts)
	require("dbtpal").setup({
		extended_path_search = true,
	})
	require("telescope").load_extension("dbtpal")
end
return M
