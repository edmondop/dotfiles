local config = {
	config = {
		justMyCode = false,
		subProcess = true,
	},
}
local set_python_debugging_keymaps = function()
	local dap_python = require("dap-python")
	vim.keymap.set("n", "<Leader>dn", function()
		dap_python.test_method(config)
	end, { buffer = 0, desc = "DAP - Test method" })

	vim.keymap.set("n", "<Leader>df", function()
		dap_python.test_class(config)
	end, { buffer = 0, desc = "DAP - Test class" })
	vim.keymap.set("n", "<Leader>ds", function()
		dap_python.debug_selection(config)
	end, { buffer = 0, desc = "DAP - Debug selection" })
end

set_python_debugging_keymaps()
