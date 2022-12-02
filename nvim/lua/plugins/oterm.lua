require('oterm').setup({
  terminal_color = 'oterm',
  split_hl = 'otermSplit',
})

local open = require('oterm').open

vim.keymap.set('n', '<c-t>', function()
  open()
end)
vim.keymap.set('n', '<M-v>', function()
  open({ layout = 'vsplit' })
end)
vim.keymap.set('n', '<M-f>', function()
  open({ layout = 'center' })
end)
