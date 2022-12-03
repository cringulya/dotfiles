vim.keymap.set('n', '<C-t>', "<CMD>lua require('FTerm').toggle()<CR>")
vim.keymap.set(
  't',
  '<C-t>',
  "<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>"
)
-- vim.keymap.set(
--   't',
--   '<ESC>',
--   "<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>"
-- )
vim.keymap.set('n', '<A-g>', function()
  require('FTerm')
    :new({
      cmd = { 'gitui' },
      dimensions = { height = 0.9, width = 0.9 },
    })
    :open()
end)
