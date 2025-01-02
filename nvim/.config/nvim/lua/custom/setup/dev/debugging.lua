local dap = require("dap")
local set_debug_sessions_keymaps = function()
	vim.keymap.set("n", "<F5>", function()
		dap.continue()
	end, { desc = "Continue" })

	vim.keymap.set("n", "<F10>", function()
		dap.continue()
	end, { desc = "Step over" })

	vim.keymap.set("n", "<F11>", function()
		dap.step_into()
	end, { desc = "Step into" })

	vim.keymap.set("n", "<F12>", function()
		dap.step_out()
	end, { desc = "Step out" })
	-- Run to cursor
	vim.keymap.set("n", "<leader>dc", function()
		dap.run_to_cursor()
	end, { desc = "DAP - Run to cursor" })

	-- REPL
	vim.keymap.set("n", "<leader>dr", function()
		dap.repl.open()
	end, { desc = "DAP - Open debugger REPL" })
end

local set_breakpoints_keymaps = function()
	vim.keymap.set("n", "<leader>db", function()
		dap.toggle_breakpoint()
	end, { desc = "DAP - Toggle breakpoint" })

	vim.keymap.set("n", "<leader>dB", function()
		dap.set_breakpoint()
	end, { desc = "DAP - Set breakpoint" })

	-- Logging / non blocking breakpoint
	vim.keymap.set("n", "<Leader>dlp", function()
		dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	end, { desc = "DAP - Log point" })
end
vim.keymap.set("n", "<leader>dL", function()
	dap.run_last()
end, { desc = "DAP - Run last" })

-- widget
local set_debugging_ui = function()
	local widgets = require("dap.ui.widgets")

	local dapui = require("dapui")
	vim.keymap.set("n", "<Leader>dwf", function()
		widgets.centered_float(widgets.frames)
	end, { desc = "DAP - Show Frames" })

	vim.keymap.set("n", "<Leader>dws", function()
		widgets.centered_float(widgets.scopes)
	end, { desc = "DAP - Show Scopes" })
	dap.listeners.before.attach.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		dapui.open()
	end

	vim.api.nvim_create_user_command("DapToggle", function()
		dapui.toggle()
	end, {})
	dapui.setup()
end

local setup_breakpoint_signs = function()
	vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointCondition", { text = "🟠", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointRejected", { text = "⚪", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapLogPoint", { text = "🔵", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapStopped", { text = "➡️,", texthl = "", linehl = "", numhl = "" })
end

--- @class Debugging
local M = {}
M.setup = function(opts)
	set_debug_sessions_keymaps()
	set_breakpoints_keymaps()
	set_debugging_ui()
	setup_breakpoint_signs()
end
return M
