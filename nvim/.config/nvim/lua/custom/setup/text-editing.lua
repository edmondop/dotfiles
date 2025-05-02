local setup_folding = function(opts)
	-- Ufo
	vim.o.foldcolumn = "1" -- '0' is not bad
	vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true
	opts = opts or {}
	local ufo = require("ufo")
	vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
	vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
	vim.keymap.set("n", "zK", function()
		local winid = ufo.peekFoldedLinesUnderCursor()
		if not winid then
			vim.lsp.buf.hover()
		end
	end, { desc = "Peek Fold" })
	ufo.setup(opts)
end

local setup_markdown_capabilities = function()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "markdown", "tex", "text" },
		callback = function()
			vim.fn["pencil#init"]()
		end,
	})
end

local setup_substitute_keymaps = function()
	local substitute = require("substitute")
	substitute.setup()
	vim.keymap.set("n", "S", substitute.operator, { desc = "Substitute with motion" })
	vim.keymap.set("n", "SS", substitute.line, { desc = "Substitute line" })
	-- vim.keymap.set("n", "S", substitute.eol, { desc = "Substitute to end of line" })
	vim.keymap.set("x", "S", substitute.visual, { desc = "Substitute in visual mode" })
	local substitute_range = require("substitute.range")
	vim.keymap.set("n", "<leader>S", substitute_range.operator, { desc = "Substitute range" })
	vim.keymap.set("x", "<leader>S", substitute_range.visual, { desc = "Substitute range" })
	vim.keymap.set("n", "<leader>SS", substitute_range.word, { desc = "Substitute range in current word" })
end

local setup_distractionfree_editing = function()
	require("zen-mode").setup({})
	require("twilight").setup({})
	vim.keymap.set("n", "<leader>zz", "<CMD>Zenmode<CR>", { desc = "Zenmode" })
	vim.keymap.set("n", "<leader>zT", "<CMD>Twilight<CR>", { desc = "Twilight" })
end

local pkmg_path = "~/Documents/PersonalKnowledge"
local vault_img_folder = "Assets/Attachments"

local setup_obsidian_editing = function()
	local uv = vim.loop -- Use Neovim's libuv wrapper to check file system
	if pkmg_path and uv.fs_stat(pkmg_path) then
		require("obsidian").setup({
			workspaces = {
				{
					name = "pkmg",
					path = pkmg_path,
				},
			}, -- Specify how to handle attachments.
			--- @diagnostic disable-next-line
			attachments = {
				img_folder = vault_img_folder,
				---@param client obsidian.Client
				---@param path obsidian.Path the absolute path to the image file
				---@return string
				img_text_func = function(client, path)
					path = client:vault_relative_path(path) or path
					return string.format("![%s](%s)", path.name, path)
				end,
			},
		})
	end
end

local setup_images_rendering = function()
	--- @diagnostic disable-next-line
	-- require("image").setup({
	-- 	processor = "magick_cli",
	-- 	integrations = {
	-- 		markdown = {
	-- 			enabled = true,
	-- 			resolve_image_path = function(document_path, image_path, fallback)
	-- 				local obsidian_client = require("obsidian").get_client()
	-- 				local full_path = vault_img_folder .. "/" .. image_path
	-- 				local new_image_path = obsidian_client:vault_relative_path(full_path).filename
	-- 				if vim.fn.filereadable(new_image_path) == 1 then
	-- 					return new_image_path
	-- 				else
	-- 					return fallback(document_path, image_path)
	-- 				end
	-- 			end,
	-- 		},
	-- 	},
	-- })
end

--- @class TextEditing
local M = {}
M.setup = function(opts)
	vim.g["pencil#conceallevel"] = 1
	setup_substitute_keymaps()
	setup_folding(opts)
	setup_images_rendering()
	setup_markdown_capabilities()
	setup_distractionfree_editing()
	setup_obsidian_editing()
	-- Extension for telescope :Telescope neoclip
	require("neoclip").setup({
		enable_persistent_history = true,
	})
	-- Additional surround (add with sa,
	-- replace with sr, find with sf,etc)
	require("mini.surround").setup({})
	require("mini.cursorword").setup()
end

return M
