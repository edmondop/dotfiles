--- @class
--- @type databases
M = {}
--- @function M.setup()
local setup_dadbot_ui = function()
	vim.keymap.set("n", "<leader>D", "<CMD>DBUIToggle<CR>", { desc = "Databases : Toggle Dadbot UI" })
end
M.setup = function()
	setup_dadbot_ui()
end
return M
