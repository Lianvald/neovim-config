return {
  "nvim-telescope/telescope-file-browser.nvim",
  keys = {
    {
      "<leader>fx",
      ":Telescope file_browser path=%:p:h=%:p:h<cr>",
      desc = "Browse files",
    },
  },
  config = function()
    require("telescope").load_extension("file_browser")
  end,
}
