local setup_auto_session = function()
	local auto_session = require("auto-session")
	auto_session.setup({
		auto_restore_enabled = false,
		auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
	})

	vim.keymap.set("n", "<leader>wr", "<CMD>SessionRestore<CR>", { desc = "Restore session for cwd" })
	vim.keymap.set("n", "<leader>ws", "<CMD>SessionSave<CR>", { desc = "Save session for auto session root dir" })
end

local setup_split_keymaps = function()
	vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
	vim.keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })
	vim.keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
	vim.keymap.set("n", "<leader>wx", "<CMD>close<CR>", { desc = "Close current split" })
	vim.keymap.set("n", "<leader>wm", "<CMD>MaximizerToggle<CR>", { desc = "Maximize/minimize a split" })
end

local setup_resize_keymaps = function()
	vim.keymap.set("n", "<C-S-Down>", ":resize +2<CR>", { desc = "Resize Horizontal Split Down" })
	vim.keymap.set("n", "<C-S-Up>", ":resize -2<CR>", { desc = "Resize Horizontal Split Up" })
	vim.keymap.set("n", "<C-S-Left>", ":vertical resize -2<CR>", { desc = "Resize Vertical Split Down" })
	vim.keymap.set("n", "<C-S-Right>", ":vertical resize +2<CR>", { desc = "Resize Vertical Split Up" })
end

local setup_navigation_keymaps = function()
	vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
	vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
	vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
	vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")
end

local setup_tabs_keymaps = function()
	vim.keymap.set("n", "<leader>To", "<CMD>tabnew<CR>", { desc = "Open new tab" })
	vim.keymap.set("n", "<leader>Tx", "<CMD>tabclose<CR>", { desc = "Close current tab" })
	vim.keymap.set("n", "<leader>Tn", "<CMD>tabn<CR>", { desc = "Go to next tab" })
	vim.keymap.set("n", "<leader>Tp", "<CMD>tabp<CR>", { desc = "Go to previous tab" })
	vim.keymap.set("n", "<leader>Tf", "<CMD>tabnew %<CR>", { desc = "Open current buffer in new tab" })
end

local setup_harpoon = function()
	local harpoon = require("harpoon")
	harpoon.setup({})
	vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
	vim.cmd("highlight! HarpoonActive guibg=NONE guifg=white")
	vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
	vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
	vim.cmd("highlight! TabLineFill guibg=NONE guifg=white")
	vim.keymap.set("n", "<leader>hm", require("harpoon.mark").add_file, { desc = "Add mark" })
	vim.keymap.set("n", "<leader>hr", require("harpoon.mark").rm_file, { desc = "Remove mark" })
	vim.keymap.set("n", "<leader>hn", require("harpoon.ui").nav_next, { desc = "Navigate to next mark" })
	vim.keymap.set("n", "<leader>hp", require("harpoon.ui").nav_prev, { desc = "Navigate to previous mark" })
	vim.keymap.set("n", "<leader>hl", ":Telescope harpoon marks<CR>", { desc = "List all Harpoon marks" })
end

local setup_toggleterm = function()
	require("toggleterm").setup({})
end

local setup_which_key = function()
	local wk = require("which-key")
	wk.setup({})
	wk.add({
		{ "<leader>B", group = "Backup" },
		{ "<leader>c", group = "Code" },
		{ "<leader>d", group = "Debug" },
		{ "<leader>e", group = "Edit config/plugins" },
		{ "<leader>f", group = "Find" },
		{ "<leader>F", group = "Flash" },
		{ "gr", group = "LSP - actions" },
		{ "grn", group = "LSP - Rename" },
		{ "<leader>G", group = "Git" },
		{ "<leader>h", group = "Harpoon" },
		{ "<leader>s", group = "Substitute" },
		{ "<leader>S", group = "Swap" },
		{ "<leader>T", group = "Tabs" },
		{ "<leader>t", group = "Tests/Troubles/Tmux" },
		{ "<leader>y", group = "Yanking" },
		{ "<leader>w", group = "Windows/Sessions" },
		{ "<leader>z", group = "Zenmode/Twlight" },
	})
end

local setup_enhanced_terminal = function()
	-- TODO: add reusable terminal from TjDevries
	vim.opt.termguicolors = true
end

local setup_lua_live_evaluation = function()
	vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
	vim.keymap.set("n", "<leader>x", ":.lua<CR>")
	vim.keymap.set("v", "<leader>x", ":lua<CR>")
end

local setup_task_warrior = function()
	local taskwarrior = require("taskwarrior_nvim")
	taskwarrior.setup({})
	vim.api.nvim_create_user_command("TaskWarriorList", function()
		taskwarrior.browser({ "ready" })
	end, {})
	-- Map the function to a keybinding
	vim.api.nvim_set_keymap("n", "<leader>Tw", "<CMD>TaskWarriorList<CR>", { desc = "Task Warrior Task List" })
end

--- @class Productivity
local M = {}
M.setup = function(opts)
	-- Automatically expand current window
	require("windows").setup()
	vim.o.winwidth = 10
	vim.o.winminwidth = 10
	vim.o.equalalways = false
	setup_auto_session()
	setup_enhanced_terminal()
	setup_harpoon()
	setup_lua_live_evaluation()
	setup_navigation_keymaps()
	setup_resize_keymaps()
	setup_split_keymaps()
	setup_tabs_keymaps()
	setup_task_warrior()
	setup_toggleterm()
	setup_which_key()
end
return M

-- TODO: review bufferline
-- require("bufferline").setup({})
