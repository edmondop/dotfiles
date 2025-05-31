local setup_file_history = function()
	local file_history = require("file_history")
	file_history.setup({
		backup_dir = "~/.file-history-git",
		git_cmd = "git",
		hostname = nil,
	})
end

local setup_file_history_keymaps = function()
	local file_history = require("file_history")
	vim.keymap.set("n", "<leader>Bb", function()
		file_history.backup()
	end, { silent = true, desc = "Create a new backup for file (with tags)" })
	vim.keymap.set("n", "<leader>Bh", function()
		file_history.history()
	end, { silent = true, desc = "Show local history of file" })
	vim.keymap.set("n", "<leader>Bf", function()
		file_history.files()
	end, { silent = true, desc = "Show local history files in repo" })
	vim.keymap.set("n", "<leader>Bq", function()
		file_history.query()
	end, { silent = true, desc = "Query local history" })
end

---@class History
local _M = {}
_M.setup = function()
	setup_file_history()
	setup_file_history_keymaps()
end
return _M
