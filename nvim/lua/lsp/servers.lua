local lsp = require('lspconfig')
local U = require('lsp.utils')

---Common perf related flags for all the LSP servers
local flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 200,
}

---Common capabilities including lsp snippets and autocompletion
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

---Common `on_attach` function for LSP servers
---@param client table
---@param buf integer
local function on_attach(client, buf)
  U.disable_formatting(client)
  U.mappings(buf)
end

-- Disable LSP logging
vim.lsp.set_log_level(vim.lsp.log_levels.OFF)

-- Configuring native diagnostics
vim.diagnostic.config({
  virtual_text = {
    source = 'always',
  },
  float = {
    source = 'always',
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    format = function(d)
      local code = d.code or (d.user_data and d.user_data.lsp.code)
      if code then
        return string.format('%s [%s]', d.message, code):gsub('1. ', '')
      end
      return d.message
    end,
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  focusable = false,
  style = 'minimal',
  border = 'rounded',
})
vim.lsp.handlers['textDocument/signatureHelp'] =
  vim.lsp.with(vim.lsp.handlers.signature_help, {
    focusable = false,
    style = 'minimal',
    borer = 'rounded',
  })

-- Lua
lsp.sumneko_lua.setup({
  flags = flags,
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      completion = {
        enable = true,
        showWord = 'Disable',
        -- keywordSnippet = 'Disable',
      },
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = { os.getenv('VIMRUNTIME') },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

lsp.jsonls.setup({
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
})

-- Angular
-- 1. install @angular/language-server globally
-- 2. install @angular/language-service inside project as dev dep
lsp.angularls.setup({
  flags = flags,
  capabilities = capabilities,
  on_attach = function(client, buf)
    client.server_capabilities.renameProvider = false
    on_attach(client, buf)
  end,
})

lsp.omnisharp.setup({
  cmd = {
    '/Users/artemson/.local/share/nvim/mason/bin/omnisharp-mono',
  },

  -- Enables support for reading code style, naming convention and analyzer
  -- settings from .editorconfig.
  enable_editorconfig_support = true,

  -- If true, MSBuild project system will only load projects for files that
  -- were opened in the editor. This setting is useful for big C# codebases
  -- and allows for faster initialization of code navigation features only
  -- for projects that are relevant to code that is being edited. With this
  -- setting enabled OmniSharp may load fewer projects and may thus display
  -- incomplete reference lists for symbols.
  enable_ms_build_load_projects_on_demand = false,

  -- Enables support for roslyn analyzers, code fixes and rulesets.
  enable_roslyn_analyzers = false,

  -- Specifies whether 'using' directives should be grouped and sorted during
  -- document formatting.
  organize_imports_on_format = false,

  -- Enables support for showing unimported types and unimported extension
  -- methods in completion lists. When committed, the appropriate using
  -- directive will be added at the top of the current file. This option can
  -- have a negative impact on initial completion responsiveness,
  -- particularly for the first few completion sessions after opening a
  -- solution.
  enable_import_completion = true,

  -- Specifies whether to include preview versions of the .NET SDK when
  -- determining which version to use for project loading.
  sdk_include_prereleases = true,

  -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
  -- true
  analyze_open_documents_only = false,
})

---List of the LSP server that don't need special configuration
local servers = {
  'zls', -- Zig
  'gopls', -- Golang
  'tsserver', -- Typescript
  'html', -- HTML
  'cssls', -- CSS
  'yamlls', -- YAML
  'emmet_ls', -- emmet-ls
  'clangd',
  'cmake',
  'jedi_language_server',
  -- 'terraformls', -- Terraform
}

local conf = {
  flags = flags,
  capabilities = capabilities,
  on_attach = on_attach,
}

for _, server in ipairs(servers) do
  lsp[server].setup(conf)
end

-- NOTE: Using `eslint_d` via `null-ls` bcz it is way fasterrrrrrr.
-- Eslint
--[[ lsp.eslint.setup({
    flags = flags,
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        useESLintClass = true, -- Recommended for eslint >= 7
        run = 'onSave', -- Run `eslint` after save
    },
    -- NOTE: `root_dir` is required to fix the monorepo issue
    root_dir = require('lspconfig.util').find_git_ancestor,
}) ]]
