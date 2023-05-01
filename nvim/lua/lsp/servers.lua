require('neodev').setup({})
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
local navic = require('nvim-navic')

---Common `on_attach` function for LSP servers
---@param client table
---@param buf integer
local function on_attach(client, buf)
  local symbols_supported =
    client.supports_method('textDocument/documentSymbol')
  if symbols_supported then
    navic.attach(client, buf)
    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
  end

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
  focusable = true,
  style = 'minimal',
  border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] =
  vim.lsp.with(vim.lsp.handlers.signature_help, {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
  })

local ls = require('luasnip')
local s = ls.snippet
local r = ls.restore_node
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node

lspsnips = {}

-- clangd
lsp.clangd.setup({
  on_attach = function(client, buf)
    navic.attach(client, buf)
    U.mappings(buf)
    local orig_rpc_request = client.rpc.request
    function client.rpc.request(method, params, handler, ...)
      local orig_handler = handler
      if method == 'textDocument/completion' then
        -- Idiotic take on <https://github.com/fannheyward/coc-pyright/blob/6a091180a076ec80b23d5fc46e4bc27d4e6b59fb/src/index.ts#L90-L107>.
        handler = function(...)
          local err, result = ...
          if not err and result then
            local items = result.items or result
            for _, item in ipairs(items) do
              -- override snippets for kind `field`, matching the snippets for member initializer lists.
              if
                item.kind == vim.lsp.protocol.CompletionItemKind.Field
                and item.textEdit.newText:match('^[%w_]+%(${%d+:[%w_]+}%)$')
              then
                local snip_text = item.textEdit.newText
                local name = snip_text:match('^[%w_]+')
                local type = snip_text:match('%{%d+:([%w_]+)%}')
                -- the snippet is stored in a separate table. It is not stored in the `item` passed to
                -- cmp, because it will be copied there and cmps [copy](https://github.com/hrsh7th/nvim-cmp/blob/ac476e05df2aab9f64cdd70b6eca0300785bb35d/lua/cmp/utils/misc.lua#L125-L143) doesn't account
                -- for self-referential tables and metatables (rightfully so, a response from lsp
                -- would contain neither), both of which are vital for a snippet.
                lspsnips[snip_text] = s('', {
                  t(name),
                  c(1, {
                    -- use a restoreNode to remember the text typed here.
                    { t('('), r(1, 'type', i(1, type)), t(')') },
                    { t('{'), r(1, 'type'), t('}') },
                  }, { restore_cursor = true }),
                })
              end
            end
          end
          return orig_handler(...)
        end
      end
      return orig_rpc_request(method, params, handler, ...)
    end
  end,
})

-- Lua
lsp.lua_ls.setup({
  on_attach = on_attach,
  flags = flags,
  capabilities = capabilities,
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
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing
      -- a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

lsp.jsonls.setup({
  on_attach = on_attach,
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

lsp.rust_analyzer.setup({
  on_attach = on_attach,
  settings = {
    ['rust-analyzer'] = {
      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
})

lsp.omnisharp.setup({
  cmd = {
    '/Users/artemson/.local/share/nvim/mason/bin/omnisharp-mono',
  },
  on_attach = on_attach,

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
  'cmake',
  -- 'jedi_language_server',
  'pyright',
  'texlab',
  'dockerls',
  'marksman',
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
