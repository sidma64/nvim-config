return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { "williamboman/mason.nvim", "jay-babu/mason-nvim-dap.nvim" },
    config = function()
      local dap = require("dap")
      require("mason-nvim-dap").setup({
        ensure_installed = { "delve" },
        handlers = {
          function(config)
            require('mason-nvim-dap').default_setup(config)
          end
        }
      })
      vim.keymap.set('n', '<Leader>dt', dap.toggle_breakpoint, {})
      vim.keymap.set('n', '<Leader>dc', dap.continue, {})
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end
  },
  -- {
  --   "leoluz/nvim-dap-go",
  --   dependencies = { "mfussenegger/nvim-dap" },
  --   config = function()
  --     require("dap-go").setup()
  --   end
  -- }
}
