local setup_tmux_navigation = function()
	require("nvim-tmux-navigation").setup({})
	vim.keymap.set("n", "<C-h>", "<CMD>NvimTmuxNavigateLeft<CR>")
	vim.keymap.set("n", "<C-j>", "<CMD>NvimTmuxNavigateDown<CR>")
	vim.keymap.set("n", "<C-k>", "<CMD>NvimTmuxNavigateUp<CR>")
	vim.keymap.set("n", "<C-l>", "<CMD>NvimTmuxNavigateRight<CR>")
end

local setup_tmux_send = function()
	local tmux_send = require("tmux_send")
	vim.keymap.set({ "n", "x" }, "<leader>t_", function()
		tmux_send.send_to_pane()
	end, { desc = "Send command to tmux" })
	vim.keymap.set({ "n", "x" }, "<leader>t_", function()
		tmux_send.send_to_pane({ add_newline = false })
	end, { desc = "Send command to tmux (no newline)" })
	vim.keymap.set({ "n", "x" }, "<C-_>", function()
		tmux_send.save_to_tmux_buffer()
	end, { desc = "Save to tmux buffer" })
end

--- @class Tmux
local _M = {}
_M.setup = function()
	setup_tmux_navigation()
	setup_tmux_send()
end
return _M
