return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    -- opts = { transparent_background = true },
    priority = 1000,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.o.background = "dark" -- or "light" for light mode
      -- vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    "Mofiqul/vscode.nvim",
    config = function()
      -- local code = require("vscode")
      -- code.setup()
      -- code.load("dark")
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      -- vim.cmd("colorscheme rose-pine")
    end,
  },
}
