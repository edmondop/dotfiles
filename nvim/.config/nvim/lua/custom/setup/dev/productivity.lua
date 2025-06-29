local setup_comments_extensions = function()
	-- Comment provides bulk commenting in linewise and blockwise mode
	-- i.e. gcc/gbc in normal mode, gc and gb in visual mode
	-- gco insert comment in the next line, gcA at the end
	--- @diagnostic disable-next-line
	require("Comment").setup({})

	local todo_comments = require("todo-comments")
	vim.keymap.set("n", "]t", function()
		todo_comments.jump_next()
	end, { desc = "Next todo comment" })

	vim.keymap.set("n", "[t", function()
		todo_comments.jump_prev()
	end, { desc = "Previous todo comment" })

	todo_comments.setup()
end

local setup_indent_guides = function()
	require("ibl").setup({
		indent = { char = "┊" },
	})
end

local setup_aerial = function()
	require("aerial").setup({
		on_attach = function(bufnr)
			vim.keymap.set("n", "{", "<CMD>AerialPrev<CR>", { buffer = bufnr })
			vim.keymap.set("n", "}", "<CMD>AerialNext<CR>", { buffer = bufnr })
		end,
	})
	vim.keymap.set("n", "<leader>A", "<CMD>AerialToggle!<CR>")
end

local setup_rainbow_delimiters = function()
	require("rainbow-delimiters.setup").setup({})
end

--- @class Productivity
local M = {}
M.setup = function()
	setup_aerial()
	setup_comments_extensions()
	setup_indent_guides()
	setup_rainbow_delimiters()
end
return M
