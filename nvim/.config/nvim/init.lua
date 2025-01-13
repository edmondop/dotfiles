
-- Special cache folder since my home directory uses ecryptfs
-- on linux, which has a PATH limit of 143
local is_linux = vim.loop.os_uname().sysname == "Linux"
-- sudo mkdir -p /var/cache/nvim
-- sudo sudo chown -R edmondo:edmondo /var/cache/nvim
if is_linux then
  vim.fn.setenv("XDG_CACHE_HOME", "/var/cache/nvim")
  vim.opt.runtimepath:prepend("/var/cache/nvim")
else
  -- Use the default cache directory for other OSes
  vim.fn.setenv("XDG_CACHE_HOME", vim.fn.stdpath("cache"))
end

-- Ensure the cache directory exists
local cache_path = vim.fn.getenv("XDG_CACHE_HOME") .. "/nvim"
if vim.fn.isdirectory(cache_path) == 0 then
  vim.fn.mkdir(cache_path, "p")
end

local lazypath = vim.fn.stdpath("data") .. "/l/lazy.nvim"
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
require("lazy").setup({ import = "custom/plugins", root = vim.fn.stdpath("data") .. "/", })
require("custom.setup").setup()
