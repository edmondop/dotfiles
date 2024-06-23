return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {
				"bash",
				"css",
				"gitignore",
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
				"json",
				"markdown",
				"proto",
				"python",
				"regex",
				"rust",
				"scala",
				"terraform",
				"tmux",
				"typescript",
			},
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
