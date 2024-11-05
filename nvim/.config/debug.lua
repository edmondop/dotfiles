local null_ls_status, null_ls = pcall(require, "null-ls")
if not null_ls_status then
    print("Error: null-ls module not found")
    return
end

local builtins_status, builtins = pcall(function() return null_ls.builtins end)
if not builtins_status then
    print("Error: builtins not found in null-ls")
    return
end

local actions_status, actions = pcall(function() return builtins.code_actions end)
if not actions_status then
    print("Error: code_actions not found in null-ls.builtins")
    return
end

for name, builtin in pairs(builtins) do
    print(name, vim.inspect(builtin))
end
for name, action in pairs(actions) do
    print(name, vim.inspect(action))
end
