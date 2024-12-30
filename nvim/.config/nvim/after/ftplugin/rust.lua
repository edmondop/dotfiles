local dap = require("dap")

if vim.g.rust_dap_adapter_configured then
	return
end
dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		-- Change this to your path!
		command = "/home/edmondo/.local/share/codelldb/extension/adapter/codelldb",
		args = { "--port", "${port}" },
	},
}

dap.configurations.rust = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}
vim.g.rust_dap_adapter_configured = true
