if vim.g.neovide then
  vim.opt.guifont = { 'Iosevka Nerd Font Mono', 'h20' }
  vim.cmd([[
  set guicursor-=a:blinkwait5-blinkon5-blinkoff5
  ]])
  vim.g.neovide_input_use_logo = true -- enable use of the logo (cmd) key
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_input_macos_alt_is_meta = false
  -- vim.g.neovide_fullscreen = 1
  vim.opt.linespace = 12

  vim.keymap.set({ 'n', 'i', 'v' }, '<D-C-f>', function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
    print('Toggle fullscreen')
  end)

  -- Change scale
  vim.g.neovide_scale_factor = 1.5
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set('n', '<D-=>', function()
    change_scale_factor(1.10)
  end)
  vim.keymap.set('n', '<D-->', function()
    change_scale_factor(1 / 1.10)
  end)

  vim.o.clipboard = ''
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<c-r>+') -- Paste insert mode
  vim.api.nvim_set_keymap(
    '',
    '<D-v>',
    '+p<CR>',
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    '!',
    '<D-v>',
    '<C-R>+',
    { noremap = true, silent = true }
  )
  vim.cmd([[
  tnoremap <expr> <D-v> '<C-\><C-N>"+pi'
  ]])

  -- vim.api.nvim_set_keymap(
  --   't',
  --   '<D-v>',
  --   '<C-><C-N>"+pi',
  --   { noremap = true, silent = true }
  -- )
  --
  vim.api.nvim_set_keymap(
    'v',
    '<D-v>',
    '<C-R>+',
    { noremap = true, silent = true }
  )
end
