local M = {}
local components = require('plugins.lualine.components')

M.config = {
  options = {
    theme = 'palenight',
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
      components.filename,
      components.diff,
      components.python_env,
    },
    lualine_x = {
      components.lsp,
      components.diagnostics,
    },
    lualine_y = { components.filetype },
    lualine_z = { components.location },
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
      components.lsp,
      components.diagnostics,
    },
    lualine_y = {
      -- components.location
      components.scrollbar,
    },
    lualine_z = {
      -- components.progress,
      components.location,
    },
  },
  tabline = {},
  extensions = {},
}

M.setup = function()
  require('lualine').setup(M.config)
end

return M
