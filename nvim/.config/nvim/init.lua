local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.g.mapleader = " "
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("vim-options")
require("lazy").setup({ import = "custom/plugins" })
require("custom.git")
require("custom.look-and-feel")
require("custom.files-navigation")
require("custom.telescope")
require("custom.text-editing")
require("custom.dev")
require("custom.productivity")
