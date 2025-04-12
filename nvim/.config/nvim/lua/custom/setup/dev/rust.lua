local dap = require("dap")

local setup_rust_debugging = function()
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
			args = function()
				local input = vim.fn.input("Arguments: ")
				return vim.split(input, " ") -- Split the input by spaces into an array
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
		},
		{
			name = "Attach to Process",
			type = "codelldb",
			request = "attach",
			pid = function()
				return vim.fn.input("PID: ")
			end,
			stopOnEntry = false,
			args = {}, -- additional arguments if necessary
		},
	}
end

--- @class Rust
local M = {}
M.setup = function(opts)
	setup_rust_debugging()
end
return M
