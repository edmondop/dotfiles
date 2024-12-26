local gitsigns = require("gitsigns")

local function map(bufnr, mode, l, r, opts)
	opts = opts or {}
	opts.buffer = bufnr
	vim.keymap.set(mode, l, r, opts)
end

local setup_hunks_staging_keymaps = function(bufnr)
	map(bufnr, "n", "<leader>Gs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
	map(bufnr, "n", "<leader>Gr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
	map(bufnr, "v", "<leader>Gs", function()
		gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "Stage Hunk" })
	map(bufnr, "v", "<leader>Gr", function()
		gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "Reset Hunk" })
	map(bufnr, "n", "<leader>GS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
	map(bufnr, "n", "<leader>Gu", gitsigns.undo_stage_hunk, { desc = "Undo Stage Hunk" })
	map(bufnr, "n", "<leader>GR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
	map(bufnr, "n", "<leader>Gp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
	map(bufnr, { "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
end

local setup_hunks_navigation_keymaps = function(bufnr)
	map(bufnr, "n", "]c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "]c", bang = true })
		else
			gitsigns.nav_hunk("next")
		end
	end)

	map(bufnr, "n", "[c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "[c", bang = true })
		else
			gitsigns.nav_hunk("prev")
		end
	end)
end

local setup_diff_keymaps = function(bufnr)
	map(bufnr, "n", "<leader>Gd", gitsigns.diffthis, { desc = "Diff This (vs staging)" })
	map(bufnr, "n", "<leader>GD", function()
		gitsigns.diffthis("~")
	end, { desc = "Diff This (vs last commit)" })
	map(bufnr, "n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle Deleted" })
end

local M = {}

---@class Git
M.setup = function()
	require("gitsigns").setup({
		on_attach = function(bufnr)
			-- Navigation
			setup_hunks_navigation_keymaps(bufnr)
			setup_hunks_staging_keymaps(bufnr)
			setup_diff_keymaps(bufnr)
			-- Others
			map(bufnr, "n", "<leader>Gb", function()
				gitsigns.blame_line({ full = true })
			end, { desc = "Blame Line" })
			map(bufnr, "n", "<leader>Gtb", gitsigns.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })
		end,
	})
	vim.keymap.set("n", "<leader>Gl", "<CMD>LazyGit<cr>", { desc = "LazyGit" })
end

return M
