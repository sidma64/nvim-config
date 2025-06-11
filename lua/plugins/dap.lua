return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { "williamboman/mason.nvim", "jay-babu/mason-nvim-dap.nvim" },
    config = function()
      local dap = require("dap")
      require("mason-nvim-dap").setup({
        ensure_installed = { "delve", "cppdbg" },
        handlers = {
          function(config)
            require('mason-nvim-dap').default_setup(config)
          end
        }
      })

      dap.adapters["lldb-dap"] = {
        type = 'executable',
        command = '/usr/bin/lldb-dap', -- adjust as needed, must be absolute path
        name = 'lldb'
      }
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
      }
      dap.configurations.c = {
        {
          name = 'Launch cppdbg',
          type = 'cppdbg',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},

          -- 💀
          -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
          --
          --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
          --
          -- Otherwise you might get the following error:
          --
          --    Error on launch: Failed to attach to the target process
          --
          -- But you should be aware of the implications:
          -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
          -- runInTerminal = false,
        },
        {
          name = 'Launch gdb',
          type = 'gdb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},

          -- 💀
          -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
          --
          --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
          --
          -- Otherwise you might get the following error:
          --
          --    Error on launch: Failed to attach to the target process
          --
          -- But you should be aware of the implications:
          -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
          -- runInTerminal = false,
        },
      }
      dap.configurations.cpp = dap.configurations.c
      dap.configurations.rust = dap.configurations.c
      vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
      vim.keymap.set('n', '<F6>', function() require('dap').step_over() end)
      vim.keymap.set('n', '<F7>', function() require('dap').step_into() end)
      vim.keymap.set('n', '<S-F7>', function() require('dap').step_out() end)
      vim.keymap.set('n', '<S-F8>', function() require('dap').restart() end)
      vim.keymap.set('n', '<F8>', function() require('dap').close() end)
      vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
      vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
      vim.keymap.set('n', '<Leader>lp',
        function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
      vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
      vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
      vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
        require('dap.ui.widgets').hover()
      end)
      vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
        require('dap.ui.widgets').preview()
      end)
      vim.keymap.set('n', '<Leader>df', function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.frames)
      end)
      vim.keymap.set('n', '<Leader>ds', function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.scopes)
      end)
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
