local dap = require("dap")
local dapui = require("dapui")
local dap_python = require("dap-python")
local widgets = require("dap.ui.widgets")

-- Debugging session hotkeys
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

-- Breakpoints
vim.keymap.set("n", "<leader>b", function()
	dap.toggle_breakpoint()
end, { desc = "DAP - Toggle breakpoint" })

vim.keymap.set("n", "<leader>B", function()
	dap.set_breakpoint()
end, { desc = "DAP - Set breakpoint" })

-- Logging / non blocking breakpoint
vim.keymap.set("n", "<Leader>lp", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "DAP - Log point" })

-- Run to cursor
vim.keymap.set("n", "<leader>rc", function()
	dap.run_to_cursor()
end, { desc = "DAP - Run to cursor" })

-- REPL
vim.keymap.set("n", "<leader>dr", function()
	dap.repl.open()
end, { desc = "DAP - Open debugger REPL" })

vim.keymap.set("n", "<leader>dl", function()
	dap.run_last()
end, { desc = "DAP - Run last" })

-- widgets

vim.keymap.set("n", "<Leader>df", function()
	widgets.centered_float(widgets.frames)
end, { desc = "DAP - Frames" })

vim.keymap.set("n", "<Leader>ds", function()
	widgets.centered_float(widgets.scopes)
end, { desc = "DAP - Frames" })

-- python
vim.keymap.set("n", "<Leader>dn", function()
	dap_python.test_method()
end, { desc = "DAP - Test method" })

vim.keymap.set("n", "<Leader>df", function()
	dap_python.test_class()
end, { desc = "DAP - Test class" })
vim.keymap.set("n", "<Leader>ds", function()
	dap_python.debug_selection()
end, { desc = "DAP - Debug selection" })

dapui.test_runner = "pytest"

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end

vim.api.nvim_create_user_command("DapToggle", function()
	dapui.toggle()
end, {})
