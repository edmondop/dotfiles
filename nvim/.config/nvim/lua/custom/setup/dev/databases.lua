--- @class
--- @type databases
M = {}
--- @function M.setup()
local setup_dadbot_ui = function()
	vim.keymap.set("n", "<leader>D", "<CMD>DBUIToggle<CR>", { desc = "Databases : Toggle Dadbot UI" })
end

local setup_ql_filetype_remapping = function()
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		pattern = "*.ql",
		command = "setfiletype sql",
	})
end
M.setup = function()
	setup_dadbot_ui()
	setup_ql_filetype_remapping()
end
return M
