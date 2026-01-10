return {
  {
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          accept = false,
        },
        panel = {
          enabled = false,
        },
        filetypes = {
          ["*"] = true,
        },
      })
      vim.keymap.set("i", "<S-Tab>", function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", false)
        end
      end, {
        silent = true,
        desc = "Accept Copilot suggestion / shift-Tab",
      })
      local copilot_suggestion = require("copilot.suggestion")

      vim.keymap.set("n", "<leader>ag", function()
        copilot_suggestion.toggle_auto_trigger()
        vim.notify("Toggled Copilot auto-suggestions")
      end, { desc = "Toggle Copilot auto-suggestions" })
    end,
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    build = "make",
    opts = {
      provider = "claude", -- chat mode uses Claude
      auto_suggestions_provider = nil, -- inline autosuggestions use Copilot
      -- optional but nice:
      cursor_applying_provider = "claude",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
  },
}
