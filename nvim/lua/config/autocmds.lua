-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
--
--

-- Disable autoformat for C# buffers when Roslyn is attached
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    -- Roslyn client name is typically "roslyn"
    if client.name == "roslyn" then
      local bufnr = args.buf
      if vim.bo[bufnr].filetype == "cs" then
        vim.b[bufnr].autoformat = false
      end
    end
  end,
})
