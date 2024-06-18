return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("catppuccin-mocha")
		vim.cmd [[
  		  highlight LineNr guifg=#F2F3F4
		  highlight CursorLineNr guifg=#FFFFFF
		]]
	end,
}
