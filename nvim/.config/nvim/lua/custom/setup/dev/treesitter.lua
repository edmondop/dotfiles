local langs = {
	"bash",
	"css",
	"diff",
	-- "gitignore",
	"gitattributes",
	"go",
	"gomod",
	"gotmpl",
	"gpg",
	"graphql",
	"hcl",
	"helm",
	"html",
	"lua",
	"luadoc",
	"json",
	"markdown",
	"proto",
	"python",
	"regex",
	"rust",
	"scala",
	"sql",
	"terraform",
	"tmux",
	"typescript",
	"vim",
	"vimdoc",
}

local select_keymaps = {
	["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
	["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
	["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
	["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

	["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
	["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

	["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
	["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

	["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
	["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

	["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
	["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

	["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
	["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

	["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
	["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
}

local swap_keymaps = {
	swap_next = {
		["<leader>sna"] = "@parameter.inner", -- swap parameters/argument with next
		["<leader>snm"] = "@function.outer", -- swap function with next
	},
	swap_previous = {
		["<leader>spa"] = "@parameter.inner", -- swap parameters/argument with prev
		["<leader>spm"] = "@function.outer", -- swap function with previous
	},
}

local move_keymaps = {
	goto_next_start = {
		["]f"] = { query = "@call.outer", desc = "Next function call start" },
		["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
		["]c"] = { query = "@class.outer", desc = "Next class start" },
		["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
		["]l"] = { query = "@loop.outer", desc = "Next loop start" },
		["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
		["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
	},
	goto_next_end = {
		["]F"] = { query = "@call.outer", desc = "Next function call end" },
		["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
		["]C"] = { query = "@class.outer", desc = "Next class end" },
		["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
		["]L"] = { query = "@loop.outer", desc = "Next loop end" },
	},
	goto_previous_start = {
		["[f"] = { query = "@call.outer", desc = "Prev function call start" },
		["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
		["[c"] = { query = "@class.outer", desc = "Prev class start" },
		["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
		["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
	},
	goto_previous_end = {
		["[F"] = { query = "@call.outer", desc = "Prev function call end" },
		["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
		["[C"] = { query = "@class.outer", desc = "Prev class end" },
		["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
		["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
	},
}

local setup_treesitter = function()
	local config = require("nvim-treesitter.configs")
	local swap = vim.tbl_extend("force", { enable = true }, swap_keymaps)
	local move = vim.tbl_extend("force", { enable = true, set_jumps = true }, move_keymaps)
	--- @diagnostic disable-next-line: missing-fields
	config.setup({
		auto_install = true,
		sync_install = false,
		ignore_install = {},
		ensure_installed = langs,
		highlight = { enable = true },
		indent = { enable = true },
		-- With this enabled you can now use <C-space> (Ctrl + space)
		-- to select the current node in the syntax tree your cursor is in.
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
		textobjects = {
			select = {
				enable = true,
				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,
				keymaps = select_keymaps,
			},
			swap = swap,
			move = move,
		},
	})
end

--- @class TreeSitter
local M = {}
M.setup = function(opts)
	setup_treesitter()
end

return M