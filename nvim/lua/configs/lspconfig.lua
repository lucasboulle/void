require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

-- Basic servers using vim.lsp.enable (new recommended API)
local servers = { "html", "cssls" }
vim.lsp.enable(servers)

-- TypeScript Language Server configuration using new vim.lsp.config API
-- To install: npm install -g typescript-language-server typescript
-- Or use Mason: :MasonInstall typescript-language-server

-- Configure ts_ls using the new vim.lsp.config approach
vim.lsp.config('ts_ls', {
  -- Use NvChad's capabilities
  capabilities = nvlsp.capabilities,
  
  -- Command to start the language server
  cmd = { 'typescript-language-server', '--stdio' },
  
  -- File types to attach to
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  
  -- Root directory detection
  root_dir = vim.fs.root(0, { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' }),
  
  -- Single file support
  single_file_support = true,
  
  -- TypeScript specific settings
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    }
  }
})

-- Enable ts_ls
vim.lsp.enable('ts_ls')

-- read :h vim.lsp.config for changing options of lsp servers 
