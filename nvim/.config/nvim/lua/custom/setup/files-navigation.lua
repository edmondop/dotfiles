local Snacks = require("snacks")

local setup_oil = function()
	require("oil").setup({
		default_file_explorer = true,
		delete_to_trash = true,
		view_options = {
			show_hidden = true,
			natural_order = true,
			is_always_hidden = function(name, _)
				return name == ".." or name == ".git"
			end,
		},
		float = {
			padding = 2,
			max_width = 90,
			max_height = 0,
		},
		win_options = {
			wrap = true,
			winblend = 0,
		},
		-- Rebinding closing to "traditional" vim keybindings
		keymaps = {
			["<C-c>"] = false,
			["q"] = "actions.close",
		},
	})
	vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open oil in parent directory" })

	vim.api.nvim_create_autocmd("User", {
		pattern = "OilActionsPost",
		callback = function(event)
			if event.data.actions.type == "move" then
				Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
			end
		end,
	})
	require("oil-git").setup({
		highlights = {
			OilGitAdded = { fg = "#a6e3a1" },
			OilGitModified = { fg = "#f9e2af" },
			OilGitDeleted = { fg = "#f38ba8" },
			OilGitRenamed = { fg = "#cba6f7" },
			OilGitUntracked = { fg = "#89b4fa" },
			OilGitIgnored = { fg = "#6c7086" },
		},
	})
end

local setup_neotree = function()
	local events = require("neo-tree.events")
	require("neo-tree").setup({
		filesystem = {
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = false,
				always_show = {
					".github",
					".config",
				},
				never_show = {
					".git",
				},
			},
			follow_current_file = {
				enabled = true,
				leave_dirs_open = false,
			},
		},
		buffers = {
			follow_current_file = {
				enabled = true,
				leave_dirs_open = false,
			},
		},
		event_handlers = {
			{
				event = events.FILE_MOVED,
				handler = function(data)
					Snacks.rename.on_rename_file(data.source, data.destination)
				end,
			},
			{
				event = events.FILE_RENAMED,
				handler = function(data)
					Snacks.rename.on_rename_file(data.source, data.destination)
				end,
			},
		},
	})
	vim.keymap.set("n", "<C-n>", "<CMD>Neotree toggle<CR>")
	vim.keymap.set("n", "<leader>nf", "<CMD>Neotree focus<CR>")
end

local setup_filepath_yanking = function()
	local function yank_path()
		if vim.bo.filetype == "oil" then
			require("oil.actions").copy_entry_path.callback()
			-- Copy the entry path to the system clipboard
			vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
			vim.notify("Copied Oil path to system clipboard", vim.log.levels.INFO)
		else
			-- Yank the full file path for regular buffers
			local path = vim.fn.expand("%:p") -- Full path
			vim.fn.setreg("+", path) -- Copy to system clipboard
			vim.notify("Yanked full path: " .. path, vim.log.levels.INFO)
		end
	end

	vim.keymap.set("n", "<leader>yp", yank_path, { desc = "Yank Path" })

	-- User command for YankPath
	vim.api.nvim_create_user_command("YankPath", function()
		yank_path()
	end, {
		desc = "Yank the file path or Oil entry path",
	})
end
setup_filepath_yanking()
--- @class FileBrowsing
local M = {}
M.setup = function(opts)
	setup_oil()
	setup_neotree()
	setup_filepath_yanking()
end
return M
