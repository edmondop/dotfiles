local ai = require("custom.plugins.dev.ai")
local databases = require("custom.plugins.dev.databases")
local dap = require("custom.plugins.dev.dap")
local diagnostics = require("custom.plugins.dev.diagnostics")
local langs = require("custom.plugins.dev.langs")
local lsp = require("custom.plugins.dev.lsp")
local parsing = require("custom.plugins.dev.parsing")
local productivity = require("custom.plugins.dev.productivity")
local remoting = require("custom.plugins.dev.remoting")
local snippets = require("custom.plugins.dev.snippets")
local testing = require("custom.plugins.dev.testing")

local result = {}
for _, tbl in ipairs({ ai, dap, databases, diagnostics, langs, lsp, parsing, productivity, remoting, snippets, testing }) do
	vim.list_extend(result, tbl)
end

return result
