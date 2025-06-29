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
	"ruff",
	"rust_analyzer",
	"sqlls",
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

			vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP - Code Action", buffer = bufnr })
			vim.keymap.set("v", "<leader>ca", function()
				if vim.lsp.buf.range_code_action then
					vim.lsp.buf.range_code_action()
				else
					vim.lsp.buf.code_action()
				end
			end, { desc = "LSP - Range Code Action", buffer = bufnr })
			-- Productivity
			vim.keymap.set(
				"n",
				"<leader>cs",
				vim.lsp.buf.signature_help,
				{ desc = "LSP - Signature help", buffer = bufnr }
			)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP - Hover documentation" })

			vim.keymap.set("n", "<leader>cd", function()
				Snacks.picker.lsp_definitions()
			end, { desc = "LSP - Go to definitions", buffer = bufnr })

			vim.keymap.set("n", "<leader>cD", function()
				Snacks.picker.lsp_declarations()
			end, { desc = "LSP - Go to declarations", buffer = bufnr })

			vim.keymap.set("n", "<leader>ci", function()
				Snacks.picker.lsp_implementations()
			end, { desc = "LSP - Go to implementations", buffer = bufnr })

			vim.keymap.set("n", "<leader>ct", function()
				Snacks.picker.lsp_type_definitions()
			end, { desc = "LSP - Go to type definition", buffer = bufnr })

			vim.keymap.set("n", "<leader>cr", function()
				vim.lsp.buf.rename()
			end, { desc = "LSP - Rename Symbol", buffer = bufnr })

			vim.keymap.set("n", "<leader>cR", function()
				Snacks.picker.lsp_references()
			end, { desc = "LSP - Go to reference", buffer = bufnr })

			vim.keymap.set("n", "<leader>cS", function()
				Snacks.picker.lsp_symbols()
			end, { desc = "LSP Symbols", buffer = bufnr })

			vim.keymap.set("n", "<leader>cW", function()
				Snacks.picker.lsp_workspace_symbols()
			end, { desc = "LSP Workspace Symbols", buffer = bufnr })

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
		automatic_installation = true,
		ensure_installed = lsps,
	})
	vim.lsp.config["basedpyright"] = {
		root_markers = { "pyrightconfig.json", "pyproject.toml", "setup.py", ".git" },
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
--- @class LSP
local M = {}
M.setup = function(opts)
	-- Orphan java, didn't know where to put it
	-- require("java").setup()
	setup_lsp_keymaps()
	setup_non_lsp_sources()
	setup_lsp_capabilities()
	setup_inline_filler()
end
return M
