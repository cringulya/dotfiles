if vim.g.vscode then
else
  require('settings')
  require('plugins')
  require('keybinds')
  require('gui-settings')
  vim.cmd([[colorscheme tokyonight-night]])
end
