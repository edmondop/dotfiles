require("gitsigns").setup({
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end)

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end)

		-- Actions
		map("n", "<leader>Gs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
		map("n", "<leader>Gr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
		map("v", "<leader>Gs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "Stage Hunk" })
		map("v", "<leader>Gr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "Reset Hunk" })
		map("n", "<leader>GS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
		map("n", "<leader>Gu", gitsigns.undo_stage_hunk, { desc = "Undo Stage Hunk" })
		map("n", "<leader>GR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
		map("n", "<leader>Gp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
		map("n", "<leader>Gb", function()
			gitsigns.blame_line({ full = true })
		end, { desc = "Blame Line" })
		map("n", "<leader>Gtb", gitsigns.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })
		map("n", "<leader>Gd", gitsigns.diffthis, { desc = "Diff This (vs staging)" })
		map("n", "<leader>GD", function()
			gitsigns.diffthis("~")
		end, { desc = "Diff This (vs last commit)" })
		map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle Deleted" })

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})
vim.keymap.set("n", "<leader>Gl", "<CMD>LazyGit<cr>", { desc = "LazyGit" })
