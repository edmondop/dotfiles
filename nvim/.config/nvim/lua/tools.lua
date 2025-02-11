local key = vim.fn.getchar()
local char = vim.fn.nr2char(key)
print("You pressed: " .. char .. " (code: " .. key .. ")")
