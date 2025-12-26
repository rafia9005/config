require("nvchad.configs.lspconfig").defaults()

local servers = {
  "cssls",
  "gopls",
  "glint",
  "intelephense",
  "lua_ls",
  -- Uncomment these if you want to use them
  -- "stimulus-language-server",
  "ts_ls"
}

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
