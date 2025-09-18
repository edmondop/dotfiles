local lsps = {
	"bashls",
	-- cannot be installed as lsp?
	-- "bacon",
	-- "bacon_ls",
	"bzl",
	"basedpyright",
	"cucumber_language_server",
	"graphql",
	"gopls",
	-- 	"jdtls",
	"jsonls",
	"lua_ls",
	-- "nil_ls", -- This will be conditionally added
	-- "pylsp",
	-- "pyrefly",
	"ruff",
	"rust_analyzer",
	"terraformls",
	"tflint",
	"ts_ls",
	"yamlls",
}
-- Check if the environment variable is set
if vim.fn.getenv("ENABLE_NIX") == "1" then
	vim.table.insert("force", lsps, "nil_ls")
end

local setup_lsp_keymaps = function()
	local disable_semantic_tokens = {
		lua = true,
	}
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local bufnr = args.buf
			local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

			vim.keymap.set("n", "gd", function()
				Snacks.picker.lsp_definitions()
			end, { desc = "LSP - Go to Definition", buffer = bufnr })

			vim.keymap.set("n", "gD", function()
				Snacks.picker.lsp_declarations()
			end, { desc = "LSP - Go to Declaration", buffer = bufnr })

			vim.keymap.set("n", "gy", function()
				Snacks.picker.lsp_type_definitions()
			end, { desc = "LSP - Go to Type Definition", buffer = bufnr })

			vim.keymap.set("n", "gs", function()
				Snacks.picker.lsp_workspace_symbols()
			end, { desc = "LSP - Workspace Symbols", buffer = bufnr })

			-- Overrides preferring Snacks picker
			vim.keymap.set("n", "grr", function()
				Snacks.picker.lsp_references()
			end, { desc = "References", buffer = bufnr })

			vim.keymap.set("n", "gri", function()
				Snacks.picker.lsp_implementations()
			end, { desc = "Implementations", buffer = bufnr })

			vim.keymap.set("n", "gO", function()
				Snacks.picker.lsp_symbols()
			end, { desc = "Document Symbols", buffer = bufnr })

			-- Override code action to use tiny-code-action
			vim.keymap.set("n", "gra", function()
				require("tiny-code-action").code_action()
			end, { desc = "Code Action", buffer = bufnr })

			vim.keymap.set("v", "gra", function()
				if vim.lsp.buf.range_code_action then
					vim.lsp.buf.range_code_action()
				else
					vim.lsp.buf.code_action()
				end
			end, { desc = "Code Action", buffer = bufnr })

			local filetype = vim.bo[bufnr].filetype
			if disable_semantic_tokens[filetype] then
				client.server_capabilities.semanticTokensProvider = nil
			end
		end,
	})
end

local setup_lsp_capabilities = function()
	require("mason").setup({})
	require("mason-lspconfig").setup({
		-- automatic_installation = true,
		ensure_installed = lsps,
	})
	vim.lsp.config["basedpyright"] = {
		root_markers = { "pyrightconfig.json", "setup.py", ".git" },
		settings = {
			basedpyright = {
				analysis = {
					diagnosticMode = "workspace",
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
				},
			},
		},
	}
	-- vim.lsp.config["pylsp"] = {
	-- 	root_markers = { "pyproject.toml", "setup.py", ".git" },
	-- 	settings = {
	-- 		pylsp = {
	-- 			plugins = {
	--
	-- 				-- Only enable pylsp-rope
	-- 				pylsp_rope = { enabled = true },
	--
	-- 				-- Disable everything else
	-- 				jedi_completion = { enabled = false },
	-- 				jedi_hover = { enabled = false },
	-- 				jedi_references = { enabled = false },
	-- 				jedi_signature_help = { enabled = false },
	-- 				jedi_symbols = { enabled = false },
	-- 				jedi_rename = { enabled = false },
	-- 				rope_completion = { enabled = false },
	-- 				rope_rename = { enabled = false },
	-- 				pyflakes = { enabled = false },
	-- 				mccabe = { enabled = false },
	-- 				preload = { enabled = false },
	-- 				yapf = { enabled = false },
	-- 				black = { enabled = false },
	-- 				autopep8 = { enabled = false },
	-- 				flake8 = { enabled = false },
	-- 				pydocstyle = { enabled = false },
	-- 				pylint = { enabled = false },
	-- 				isort = { enabled = false },
	-- 				mypy = { enabled = false },
	-- 				pycodestyle = { enabled = false },
	-- 			},
	-- 		},
	-- 	},
	-- }
	for _, lsp in ipairs(lsps) do
		vim.lsp.enable(lsp)
	end
end

local tools = {
	{ name = "stylua", capabilities = { "formatting" } },
	{ name = "hclfmt", capabilities = { "formatting" } },
	{ name = "shfmt", capabilities = { "formatting" } },
	{ name = "prettier", capabilities = { "formatting" } },
	{ name = "buf", capabilities = { "formatting", "diagnostics" } },
	{ name = "goimports", capabilities = { "formatting" } },
	{ name = "actionlint", capabilities = { "diagnostics" } },
	{ name = "sqlfluff", capabilities = { "formatting", "diagnostics" } },
}

local setup_non_lsp_sources = function()
	require("mason-tool-installer").setup({
		ensure_installed = vim.tbl_map(function(tool)
			return tool.name
		end, tools),
	})

	local null_ls = require("null-ls")

	local sources = {}
	for _, tool in ipairs(tools) do
		for _, capability in ipairs(tool.capabilities) do
			vim.tbl_extend("force", sources, null_ls.builtins[capability][tool.name])
		end
	end
	null_ls.setup({ sources = sources, debug = true })
end

local setup_inline_filler = function()
	local inlayhint_filler = require("inlayhint-filler")
	inlayhint_filler.setup({})
	vim.keymap.set("n", "<leader>ci", function()
		inlayhint_filler.fill()
	end, { desc = "LSP: Inlay Hints" })
end
local setup_tiny_codeaction = function()
	require("tiny-code-action").setup({
		backend = "delta",
		picker = "snacks",
	})
	local finder = require("tiny-code-action.finder")
	local weight = { pyright = 0, ruff = 1 }

	finder.sort_by_preferred = function(results)
		if not results or #results == 0 then
			return results
		end
		table.sort(results, function(a, b)
			-- 1. client priority (pyright < ruff < everything else)
			-- 2. preferred flag coming from LSP
			-- 3. alphabetical order of the action title
			local wa = weight[a.client.name] or 99
			local wb = weight[b.client.name] or 99
			if wa ~= wb then
				return wa < wb
			end

			-- 2. “preferred” flag inside the CodeAction itself
			local pa = a.action and a.action.isPreferred or false
			local pb = b.action and b.action.isPreferred or false
			if pa ~= pb then
				return pa
			end

			return (a.action.title or "") < (b.action.title or "")
		end)
		return results
	end
end
--- @class LSP
local M = {}
M.setup = function(opts)
	-- Orphan java, didn't know where to put it
	-- require("java").setup()
	setup_tiny_codeaction()
	setup_lsp_keymaps()
	setup_non_lsp_sources()
	setup_lsp_capabilities()
	setup_inline_filler()
end
return M
