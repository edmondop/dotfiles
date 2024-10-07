local null_ls = require("null-ls")
local actions = null_ls.builtins.code_actions

for name, builtin in pairs(null_ls.builtins) do
	print(name, vim.inspect(builtin))
end
for name, action in pairs(actions) do
	print(name, vim.inspect(action))
end
