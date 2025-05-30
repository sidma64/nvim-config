return {
  { "williamboman/mason.nvim", opts = {}, dependencies = { "williamboman/mason-lspconfig.nvim" } },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp", "b0o/schemastore.nvim" },
    config = function()
      local configs = {
        ["racket_langserver"] = {},
        ["lua_ls"] = {},
        ["clangd"] = {},
        ["cmake"] = {},
        ["pyright"] = {},
        ["hyprls"] = {},
        ["ts_ls"] = {},
        ["html"] = {},
        ["jsonls"] = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },
        ["gopls"] = {},
        ["nixd"] = {},
        ["nushell"] = {},
        ["taplo"] = {},
        ["yamlls"] = {
          settings = {
            yaml = {
              schemaStore = {
                -- You must disable built-in schemaStore support if you want to use
                -- this plugin and its advanced options like `ignore`.
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
              },
              schemas = require('schemastore').yaml.schemas(),
            },
          },
        },
        ["rust_analyzer"] = {},
        ["graphql"] = {},
      }
      local default_config = {}
      for name, config in pairs(configs) do
        config = vim.tbl_deep_extend("force", default_config, config)
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        require("lspconfig")[name].setup(config)
      end
    end,
  }
}
