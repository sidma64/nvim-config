return {
  "folke/persistence.nvim",
  opts = {},
  config = function(_, opts)
    local persistence = require("persistence")
    persistence.setup(opts)

    -- load the session for the current directory
    vim.keymap.set("n", "<leader>qs", function()
      persistence.load()
    end)

    -- select a session to load
    vim.keymap.set("n", "<leader>qS", function()
      persistence.select()
    end)

    -- load the last session
    vim.keymap.set("n", "<leader>ql", function()
      persistence.load({ last = true })
    end)

    -- stop Persistence => session won't be saved on exit
    vim.keymap.set("n", "<leader>qd", function()
      persistence.stop()
    end)
  end,
}
