require('toggleterm').setup({
  start_in_insert = true,
})

vim.keymap.set({ 'n', 't' }, '<c-m>', '<cmd>ToggleTerm<cr>')
vim.keymap.del({ 'n', 't' }, '<cr>')
