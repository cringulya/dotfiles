local types = require('luasnip.util.types')

require('luasnip').setup({
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { '●', 'DiffAdd' } },
      },
    },
    [types.insertNode] = {
      active = {
        virt_text = { { '●', 'DiffDelete' } },
      },
    },
  },
})

-- Loading any vscode snippets from plugins
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_vscode').lazy_load({
  paths = '~/.config/nvim/snippets',
})

-- Allow jsx and tsx to use js snippets
require('luasnip').filetype_extend(
  'javascript',
  { 'javascriptreact', 'typescriptreact' }
)

-- Mappins to move around inside snippets
vim.keymap.set({ 'i', 's' }, '<c-l>', '<CMD>lua require("luasnip").jump(1)<CR>')
vim.keymap.set(
  { 'i', 's' },
  '<c-h>',
  '<CMD>lua require("luasnip").jump(-1)<CR>'
)
