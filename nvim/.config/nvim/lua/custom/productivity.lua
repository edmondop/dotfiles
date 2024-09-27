local auto_session = require("auto-session")

auto_session.setup({
	auto_restore_enabled = false,
	auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
})

vim.keymap.set("n", "<leader>wr", "<CMD>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
vim.keymap.set("n", "<leader>ws", "<CMD>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory

-- Windows Management
vim.o.winwidth = 10
vim.o.winminwidth = 10
vim.o.equalalways = false
require("windows").setup()
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
vim.keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
vim.keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
vim.keymap.set("n", "<leader>wx", "<CMD>close<CR>", { desc = "Close current split" }) -- close current split window
vim.keymap.set("n", "<leader>wm", "<CMD>MaximizerToggle<CR>", { desc = "Maximize/minimize a split" })

-- Tmux
require("nvim-tmux-navigation").setup({})
vim.keymap.set("n", "<C-h>", "<CMD>NvimTmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-j>", "<CMD>NvimTmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<CMD>NvimTmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-l>", "<CMD>NvimTmuxNavigateRight<CR>")

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.keymap.set("n", "<leader>to", "<CMD>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
vim.keymap.set("n", "<leader>tx", "<CMD>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
vim.keymap.set("n", "<leader>tn", "<CMD>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
vim.keymap.set("n", "<leader>tp", "<CMD>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
vim.keymap.set("n", "<leader>tf", "<CMD>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
-- Harpoon
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

-- Buffer lines
vim.opt.termguicolors = true
require("bufferline").setup({})
local wk = require("which-key")
wk.setup({})
wk.register({
	["<leader>"] = {
		c = {
			name = "Code",
		},
		f = {
			name = "Find",
		},
		g = {
			name = "LSP",
		},
		G = {
			name = "Git",
		},
		h = {
			name = "Harpoon",
		},
		n = {
			name = "Navigation(files)",
		},
		t = {
			name = "Tabs",
		},
		T = {
			name = "Tests/Troubles",
		},
		w = {
			name = "Windows/Sessions",
		},
		z = {
			name = "Zenmode/Twlight",
		},
	},
})
