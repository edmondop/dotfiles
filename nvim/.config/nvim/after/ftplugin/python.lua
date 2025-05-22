local set_python_debugging_keymaps = function()
	local dap_python = require("dap-python")
	vim.keymap.set("n", "<Leader>dn", function()
		dap_python.test_method({ justMyCode = false })
	end, { buffer = 0, desc = "DAP - Test method" })

	vim.keymap.set("n", "<Leader>df", function()
		dap_python.test_class({ justMyCode = false })
	end, { buffer = 0, desc = "DAP - Test class" })
	vim.keymap.set("n", "<Leader>ds", function()
		dap_python.debug_selection({ justMyCode = false })
	end, { buffer = 0, desc = "DAP - Debug selection" })
end

set_python_debugging_keymaps()
