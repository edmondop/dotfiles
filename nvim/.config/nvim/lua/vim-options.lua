vim.wo.number = true

local set = vim.opt
set.undofile = true
set.swapfile = false
set.tabstop = 2
set.shiftwidth = 4
set.expandtab = true
set.autoindent = true
-- use clipboard as default registry
set.clipboard:append("unnamedplus")

-- Always split in certain directions
set.splitright = true
-- set.splitbelow = true

-- Conceal level for Obsidian
-- https://github.com/epwalsh/obsidian.nvim#concealing-characters
set.conceallevel = 1

-- Relative numbers useful to move up and down
set.relativenumber = true

vim.filetype.add({
	extension = {
		ql = "sql",
	},
})

-- Required to run Pyright at scale
vim.env.NODE_OPTIONS = "--max-old-space-size=8192"

vim.opt.exrc = true -- Enable loading of .nvimrc / .nvim.lua files
vim.opt.secure = true -- Restrict usage of some commands in .nvimrc files or .nvim.lua files
