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
vim.keymap.set("n", "<leader><leader>x", "<CMD>source % <CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")
vim.keymap.set("n", "<leader>Drf", "<cmd>DbtRun<cr>", { desc = "DBT Run Model" })
vim.keymap.set("n", "<leader>Drp", "<cmd>DbtRunAll<cr>", { desc = "DBT Run Model" })
vim.keymap.set("n", "<leader>Dtf", "<cmd>DbtTest<cr>", { desc = "DBT Test" })
vim.keymap.set("n", "<leader>Dm", "<cmd>lua require('dbtpal.telescope').dbt_picker()<cr>", { desc = "DBT Run Model" })
require("dbtpal").setup({})
require("telescope").load_extension("dbtpal")
