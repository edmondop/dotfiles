local setup_buffer_pickers = function()
	vim.keymap.set("n", "<leader>fb", function()
		Snacks.picker.buffers()
	end, { desc = "Find Buffers" })
	vim.keymap.set("n", "<leader>fB", function()
		Snacks.picker.grep_buffers()
	end, { desc = "Grep Open Buffers" })
	vim.keymap.set("n", "<leader>fl", function()
		Snacks.picker.lines()
	end, { desc = "Find Line in current buffer" })
end

local setup_history_pickers = function()
	vim.keymap.set("n", "<leader>fc", function()
		Snacks.picker.command_history()
	end, { desc = "Command History" })
	vim.keymap.set("n", "<leader>fn", function()
		Snacks.picker.notifications()
	end, { desc = "Notification History" })
	vim.keymap.set("n", "<leader>fs", function()
		Snacks.picker.search_history()
	end, { desc = "Search History" })
	vim.keymap.set("n", "<leader>fu", function()
		Snacks.picker.undo()
	end, { desc = "Undo History" })
end

local setup_help_pickers = function()
	vim.keymap.set("n", "<leader>fh", function()
		Snacks.picker.help()
	end, { desc = "Find Help Pages" })
	vim.keymap.set("n", "<leader>fm", function()
		Snacks.picker.man()
	end, { desc = "Find Man Pages" })
end

local setup_file_pickers = function()
	vim.keymap.set("n", "<leader><leader>", function()
		Snacks.picker.smart()
	end, { desc = "Smart Files" })
	vim.keymap.set("n", "<leader>fg", function()
		Snacks.picker.grep()
	end, { desc = "Grep" })
	vim.keymap.set({ "n", "x" }, "<leader>fG", function()
		Snacks.picker.grep_word()
	end, { desc = "Grep selection or word" })
	vim.keymap.set("n", "<leader>ff", function()
		Snacks.picker.files()
	end, { desc = "Find Files" })
end

local setup_config_pickers = function()
	vim.keymap.set("n", "<leader>en", function()
		Snacks.picker.files({
			cwd = vim.fn.stdpath("config"),
		})
	end, { desc = "Find a Neovim config file" })
	-- Edit plugins
	vim.keymap.set("n", "<space>ep", function()
		Snacks.picker.files({
			cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
		})
	end, { desc = "Find a Plugin source file" })
end

local setup_utilities_pickers = function(opts)
	vim.keymap.set("n", "<leader>u", function()
		Snacks.picker.undo()
	end, { desc = "Undo History" })
	vim.keymap.set("n", "<leader>r", function()
		Snacks.picker.registers()
	end, { desc = "Registers" })
end

local setup_keymaps_pickers = function()
	vim.keymap.set("n", "<leader>fk", function()
		Snacks.picker.keymaps()
	end, { desc = "Keymaps" })
end

local setup_diagnostics_pickers = function()
	vim.keymap.set("n", "<leader>fd", function()
		Snacks.picker.diagnostics()
	end, { desc = "Diagnostics" })
end

local M = {}
M.setup = function(opts)
	opts = opts or {}
	require("snacks").setup({
		picker = {
			sources = {
				grep = {
					hidden = true, -- This becomes part of `opts` in the grep finder
				},
			},
		},
	})
	setup_buffer_pickers(opts)
	setup_diagnostics_pickers(opts)
	setup_file_pickers(opts)
	setup_help_pickers(opts)
	setup_history_pickers(opts)
	setup_config_pickers(opts)
	setup_utilities_pickers(opts)
	setup_keymaps_pickers(opts)
end
return M
