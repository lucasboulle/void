require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

-- Basic servers using vim.lsp.enable (new recommended API)
local servers = { "html", "cssls", "gopls" }
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

-- Go Language Server (gopls) configuration using new vim.lsp.config API
-- To install: go install golang.org/x/tools/gopls@latest
-- Or use Mason: :MasonInstall gopls (requires Go to be installed first)

-- Check if gopls is available before configuring
if vim.fn.executable('gopls') == 1 then
  vim.lsp.config('gopls', {
    capabilities = nvlsp.capabilities,
    
    cmd = { 'gopls' },
    
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    
    root_dir = vim.fs.root(0, { 'go.mod', '.git', 'go.work' }),
    
    single_file_support = true,
    
    -- Go specific settings (updated for newer gopls)
    settings = {
      gopls = {
        -- Code completion
        completeUnimported = true,
        usePlaceholders = true,
        
        -- Analysis and diagnostics (removed deprecated fieldalignment)
        analyses = {
          unusedparams = true,
          shadow = true,
          nilness = true,
          unusedwrite = true,
          useany = true,
        },
        
        -- Code actions
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        
        -- Inlay hints
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        
        -- Build flags
        buildFlags = { "-tags", "integration" },
        
        -- Formatting
        gofumpt = true,
        
        -- Import organization
        ["local"] = "",
        
        -- Semantic tokens
        semanticTokens = true,
      }
    }
  })
  
  -- Enable gopls
  vim.lsp.enable('gopls')
else
  vim.notify("gopls not found. Install with: go install golang.org/x/tools/gopls@latest", vim.log.levels.WARN)
end

-- read :h vim.lsp.config for changing options of lsp servers 
