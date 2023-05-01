local nls = require('null-ls')
local U = require('lsp.utils')

local fmt = nls.builtins.formatting
local dgn = nls.builtins.diagnostics
local cda = nls.builtins.code_actions

-- Configuring null-ls
nls.setup({
  sources = {
    ----------------
    -- FORMATTING --
    ----------------
    fmt.trim_whitespace.with({
      filetypes = { 'text', 'zsh', 'toml', 'make', 'conf', 'tmux' },
    }),
    -- NOTE:
    -- 1. both needs to be enabled to so prettier can apply eslint fixes
    -- 2. prettierd should come first to prevent occassional race condition
    fmt.prettier,
    fmt.latexindent.with({
      extra_args = { '-c', '~/.local/share/nvim/mason/packages/latexindent/' },
    }),
    fmt.eslint_d,
    -- fmt.prettier.with({
    --     extra_args = {
    --         '--tab-width=4',
    --         '--trailing-comma=es5',
    --         '--end-of-line=lf',
    --         '--arrow-parens=always',
    --     },
    -- }),
    fmt.rustfmt,
    fmt.stylua,
    fmt.gofmt,
    fmt.zigfmt,
    fmt.black.with({
      extra_args = { '--preview' },
    }),
    fmt.shfmt.with({
      extra_args = { '-i', 4, '-ci', '-sr' },
    }),
    -----------------
    -- DIAGNOSTICS --
    -----------------
    dgn.shellcheck,
    dgn.luacheck.with({
      extra_args = { '--globals', 'vim', '--std', 'luajit' },
    }),
    -- dgn.flake8,
    ------------------
    -- CODE ACTIONS --
    ------------------
    cda.shellcheck,
  },

  on_attach = function(client, bufnr)
    U.fmt_on_save(client, bufnr)
    U.mappings(bufnr)
  end,
})
