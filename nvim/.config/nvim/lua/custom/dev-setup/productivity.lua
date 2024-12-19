-- Indent
require("ibl").setup({
	indent = { char = "┊" },
})

require("Comment").setup({})

local todo_comments = require("todo-comments")
vim.keymap.set("n", "]t", function()
	todo_comments.jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
	todo_comments.jump_prev()
end, { desc = "Previous todo comment" })

todo_comments.setup()

require("aerial").setup({
	on_attach = function(bufnr)
		vim.keymap.set("n", "{", "<CMD>AerialPrev<CR>", { buffer = bufnr })
		vim.keymap.set("n", "}", "<CMD>AerialNext<CR>", { buffer = bufnr })
	end,
})
vim.keymap.set("n", "<leader>A", "<CMD>AerialToggle!<CR>")
-- Lua re-evaluation in memory
vim.keymap.set("n", "<leader><leader>x", "<CMD> source % <CR>")
vim.keymap.set("n", "<leader>x", "<CMD>: .lua<CR>")
vim.keymap.set("v", "<leader>x", "<CMD>: lua<CR>")
