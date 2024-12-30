local setup_trouble = function()
	vim.keymap.set("n", "<leader>TX", "<CMD>Trouble diagnostics toggle<cr>", { desc = "Trouble - Diagnostics" })

	vim.keymap.set(
		"n",
		"<leader>TB",
		"<CMD>Trouble diagnostics toggle filter.buf=0<cr>",
		{ desc = "Buffer Diagnostics (Trouble)" }
	)

	vim.keymap.set("n", "<leader>TS", "<CMD>Trouble symbols toggle focus=false<cr>", { desc = "Trouble - Symmbols" })

	vim.keymap.set(
		"n",
		"<leader>TR",
		"<CMD>Trouble lsp toggle focus=false win.position=right<cr>",
		{ desc = "Trouble - LSP Definitions / references / ... (Trouble)" }
	)

	vim.keymap.set("n", "<leader>TL", "<CMD>Trouble loclist toggle<cr>", { desc = "Location List" })

	vim.keymap.set("n", "<leader>TQ", "<CMD>Trouble qflist toggle<cr>", {
		desc = "Trouble - Quickfix List",
	})
end

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

--- @class Productivity
local M = {}
M.setup = function()
	setup_aerial()
	setup_comments_extensions()
	setup_indent_guides()
	setup_trouble()
end
return M
