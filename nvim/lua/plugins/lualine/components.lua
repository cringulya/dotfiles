local conditions = require('plugins.lualine.conditions')
local colors = require('plugins.lualine.colors')
local lv_icons = require('icons')

local function list_registered_names(filetype)
  local s = require('null-ls.sources')
  local available_sources = s.get_available(filetype)
  local registered = {}
  for _, source in ipairs(available_sources) do
    for method in pairs(source.methods) do
      registered[method] = registered[method] or {}
      table.insert(registered[method], source.name)
    end
  end
  return registered
end

local function list_registered_formaters(filetype)
  local method = require('null-ls').methods.FORMATTING
  local registered_providers = list_registered_names(filetype)
  return registered_providers[method] or {}
end

local function list_registered_linters(filetype)
  local null_ls = require('null-ls')
  local alternative_methods = {
    null_ls.methods.DIAGNOSTICS,
    null_ls.methods.DIAGNOSTICS_ON_OPEN,
    null_ls.methods.DIAGNOSTICS_ON_SAVE,
  }
  local registered_providers = list_registered_names(filetype)
  local providers_for_methods = vim.tbl_flatten(vim.tbl_map(function(m)
    return registered_providers[m] or {}
  end, alternative_methods))

  return providers_for_methods
end

local function env_cleanup(venv)
  if string.find(venv, "/") then
    local final_venv = venv
    for w in venv:gmatch "([^/]+)" do
      final_venv = w
    end
    venv = final_venv
  end
  return venv
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local branch = lv_icons.git.Branch

return {
  mode = {
    function()
      return ' ' .. lv_icons.ui.Target .. ' '
    end,
    padding = { left = 0, right = 0 },
    color = {},
    cond = nil,
  },
  branch = {
    'b:gitsigns_head',
    icon = branch,
    color = { gui = 'bold' },
  },
  filename = {
    'filename',
    color = {},
    cond = nil,
  },
  diff = {
    'diff',
    source = diff_source,
    symbols = {
      added = lv_icons.git.LineAdded .. ' ',
      modified = lv_icons.git.LineModified .. ' ',
      removed = lv_icons.git.LineRemoved .. ' ',
    },
    padding = { left = 2, right = 1 },
    diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.yellow },
      removed = { fg = colors.red },
    },
    cond = nil,
  },
  python_env = {
    function()
      if vim.bo.filetype == 'python' then
        local venv = os.getenv('CONDA_DEFAULT_ENV') or os.getenv('VIRTUAL_ENV')
        if venv then
          local icons = require('nvim-web-devicons')
          local py_icon, _ = icons.get_icon('.py')
          return string.format(
            ' ' .. py_icon .. ' (%s)',
            env_cleanup(venv)
          )
        end
      end
      return ''
    end,
    color = { fg = colors.green },
    cond = conditions.hide_in_width,
  },
  diagnostics = {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = {
      error = lv_icons.diagnostics.BoldError .. ' ',
      warn = lv_icons.diagnostics.BoldWarning .. ' ',
      info = lv_icons.diagnostics.BoldInformation .. ' ',
      hint = lv_icons.diagnostics.BoldHint .. ' ',
    },
    -- cond = conditions.hide_in_width,
  },
  treesitter = {
    function()
      return lv_icons.ui.Tree
    end,
    color = function()
      local buf = vim.api.nvim_get_current_buf()
      local ts = vim.treesitter.highlighter.active[buf]
      return {
        fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red,
      }
    end,
    cond = conditions.hide_in_width,
  },
  lsp = {
    function(msg)
      msg = msg or 'LS Inactive'
      local buf_clients = vim.lsp.buf_get_clients()
      if next(buf_clients) == nil then
        -- TODO: clean up this if statement
        if type(msg) == 'boolean' or #msg == 0 then
          return 'LS Inactive'
        end
        return msg
      end
      local buf_ft = vim.bo.filetype
      local buf_client_names = {}
      local copilot_active = false

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= 'null-ls' and client.name ~= 'copilot' then
          table.insert(buf_client_names, client.name)
        end

        if client.name == 'copilot' then
          copilot_active = true
        end
      end

      -- add formatter
      local supported_formatters = list_registered_formaters(buf_ft)
      vim.list_extend(buf_client_names, supported_formatters)

      -- add linter
      local supported_linters = list_registered_linters(buf_ft)
      vim.list_extend(buf_client_names, supported_linters)

      local unique_client_names = vim.fn.uniq(buf_client_names)

      local language_servers = '['
        .. table.concat(unique_client_names, ', ')
        .. ']'

      if copilot_active then
        language_servers = language_servers
          .. '%#SLCopilot#'
          .. ' '
          .. lv_icons.git.Octoface
          .. '%*'
      end

      return language_servers
    end,
    color = { gui = 'bold' },
    cond = conditions.hide_in_width,
  },
  location = { 'location' },
  progress = {
    'progress',
    fmt = function()
      return '%P/%L'
    end,
    color = {},
  },

  spaces = {
    function()
      local shiftwidth = vim.api.nvim_buf_get_option(0, 'shiftwidth')
      return lv_icons.ui.Tab .. ' ' .. shiftwidth
    end,
    padding = 1,
  },
  encoding = {
    'o:encoding',
    fmt = string.upper,
    color = {},
    cond = conditions.hide_in_width,
  },
  filetype = { 'filetype', cond = nil, padding = { left = 1, right = 1 } },
  scrollbar = {
    function()
      local current_line = vim.fn.line('.')
      local total_lines = vim.fn.line('$')
      local chars = {
        '__',
        '▁▁',
        '▂▂',
        '▃▃',
        '▄▄',
        '▅▅',
        '▆▆',
        '▇▇',
        '██',
      }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end,
    padding = { left = 0, right = 0 },
    color = 'SLProgress',
    cond = nil,
  },
}
