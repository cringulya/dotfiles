vim.opt.guifont = { 'Iosevka Nerd Font Mono', 'h20' }

if vim.g.neovide then
  vim.g.neovide_scale_factor = 2.0
  vim.g.neovide_input_use_logo = true
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_fullscreen = true
  vim.g.neovide_input_macos_alt_is_meta = false
  vim.keymap.set(
    {'n', 'i', 'v'},
    '<D-C-f>',
    function ()
      vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
      print("Toggle fullscreen")
    end
  )

  vim.keymap.set(
    {'n', 'v'},
    '<D-c>',
    '"+y'
  )

  vim.keymap.set(
    'i',
    '<D-v>',
    '<C-r>*'
  )

end
