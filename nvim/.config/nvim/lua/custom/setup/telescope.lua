local telescope = require("telescope")

local setup_extensions = function()
	telescope.load_extension("harpoon")
	telescope.load_extension("noice")
	telescope.load_extension("ui-select")
	telescope.load_extension("undo")
end

--- @class Telescope
local M = {}
M.setup = function(opts)
	setup_extensions()
end
return M
