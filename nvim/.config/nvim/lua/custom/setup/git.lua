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
	map(bufnr, "n", "<leader>Gp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
	map(bufnr, { "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	map(bufnr, "n", "<leader>Gu", gitsigns.undo_stage_hunk, { desc = "Undo Stage Hunk" })
	-- Buffers
	map(bufnr, "n", "<leader>GS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
	map(bufnr, "n", "<leader>GR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
end

local setup_hunks_navigation_keymaps = function(bufnr)
	map(bufnr, "n", "]c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "]c", bang = true })
		else
			gitsigns.nav_hunk("next")
		end
	end, { desc = "Next hunk" })

	map(bufnr, "n", "[c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "[c", bang = true })
		else
			gitsigns.nav_hunk("prev")
		end
	end, { desc = "Previous hunk" })
end

local setup_diff_keymaps = function(bufnr)
	map(bufnr, "n", "<leader>Gd", gitsigns.diffthis, { desc = "Diff This (vs staging)" })
	map(bufnr, "n", "<leader>Gb", function()
		Snacks.picker.git_branches(function(branch)
			if branch then
				gitsigns.diffthis(branch)
			end
		end)
	end, { desc = "Diff This (vs picked branch)" })
	map(bufnr, "n", "<leader>GM", function()
		gitsigns.diffthis("~")
	end, { desc = "Diff This (vs master)" })
	map(bufnr, "n", "<leader>GD", function()
		gitsigns.diffthis("~")
	end, { desc = "Diff This (vs last commit)" })
	map(bufnr, "n", "<leader>GP", gitsigns.preview_hunk_inline, { desc = "Preview Hunk Inline / Toggle Deleted" })
end

local setup_neogit = function()
	local neogit = require("neogit")
	neogit.setup({})
	vim.keymap.set("n", "<leader>GN", "<CMD>Neogit<cr>", { desc = "Neogit" })
end

local setup_snacks_git_picker = function()
	vim.keymap.set("n", "<leader>GB", function()
		Snacks.picker.git_branches()
	end, { desc = "Git branches" })
	vim.keymap.set("n", "<leader>Gl", function()
		Snacks.picker.git_log()
	end, { desc = "Git log" })
	vim.keymap.set("n", "<leader>Gf", function()
		Snacks.picker.git_log_file()
	end, { desc = "Git log file" })
	vim.keymap.set("n", "<leader>Gd", function()
		Snacks.picker.git_diff()
	end, { desc = "Git list diffs" })
end

local M = {}
---@class Git
M.setup = function()
	require("gitsigns").setup({
		watch_gitdir = {
			enable = false, -- Don't watch git directory for changes
		},
		attach_to_untracked = false,
		current_line_blame = false, -- Disable automatic blame
		update_debounce = 999999, -- Essentially never auto-update
		on_attach = function(bufnr)
			-- Navigation
			setup_hunks_navigation_keymaps(bufnr)
			setup_hunks_staging_keymaps(bufnr)
			setup_diff_keymaps(bufnr)
			-- Others
			map(bufnr, "n", "<leader>Gl", function()
				gitsigns.blame_line({ full = true })
			end, { desc = "Blame Line" })
			map(bufnr, "n", "<leader>Gtb", gitsigns.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })
		end,
	})
	setup_neogit()
	setup_snacks_git_picker()
end

return M
