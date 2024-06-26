<<<<<<< HEAD:nvim/.config/nvim/lua/custom/plugins/which-key.lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
}
||||||| parent of 393eb50 (Saving local changes for capital one):nvim/.config/nvim/lua/custom/plugins/which-key.lua
=======
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
}
>>>>>>> 393eb50 (Saving local changes for capital one):nvim/.config/nvim/lua/plugins/which-key.lua
