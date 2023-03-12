local betterTerm = require('betterTerm')

betterTerm.setup({
  prefix = 'Term_',
  startInserted = true,
  position = 'bot',
  size = 15,
})

vim.keymap.set('t', '<ESC>', '<C-\\><C-n><CR>')

vim.keymap.set('n', '`<cr>', function()
  require('betterTerm').send(
    require('code_runner.commands').get_filetype_command(),
    1,
    { clean = true, interrupt = true }
  )
  betterTerm.open(1)
end, { desc = 'Excute File' })

vim.keymap.set(
  { 'n', 't' },
  '<C-m>',
  betterTerm.open,
  { desc = 'Open terminal' }
)

vim.keymap.del({ 't', 'n' }, '<cr>')
