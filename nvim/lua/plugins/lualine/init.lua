local M = {}
local components = require('plugins.lualine.components')
local navic = require('nvim-navic')

M.config = {
  options = {
    theme = 'auto',
    globalstatus = true,
    icons_enabled = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'alpha' },
  },
  sections = {
    lualine_a = {
      components.mode,
    },
    lualine_b = {
      components.branch,
    },
    lualine_c = {
      components.diff,
      components.python_env,
    },
    lualine_x = {
      components.diagnostics,
      components.lsp,
      components.spaces,
      components.filetype,
    },
    lualine_y = { components.location },
    lualine_z = {
      components.progress,
    },
  },
  inactive_sections = {
    lualine_a = {
      components.mode,
    },
    lualine_b = {
      components.branch,
    },
    lualine_c = {
      components.diff,
      components.python_env,
    },
    lualine_x = {
      components.diagnostics,
      components.lsp,
      components.spaces,
      components.filetype,
    },
    lualine_y = { components.location },
    lualine_z = {
      components.progress,
    },
  },
  tabline = {},
  extensions = {},
}

M.setup = function()
  require('lualine').setup(M.config)
end

return M
