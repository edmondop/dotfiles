vim.wo.number = true

local set = vim.opt
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
