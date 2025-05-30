return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = {},
      modules = {},
      incremental_selection = {
        enable = false,
        keymaps = {
          init_selection = "gnn",   -- set to `false` to disable one of the mappings
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decrecental = "grm",
        },
      },
      auto_install = true,
      sync_install = true,
      ignore_install = {},
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      indent = { enable = true },
    })
  end,
}
