local actions = require('telescope.actions')
local lactions = require('telescope.actions.layout')
local finders = require('telescope.builtin')

require('telescope').setup({
  defaults = {
    prompt_prefix = ' ❯ ',
    initial_mode = 'insert',
    sorting_strategy = 'ascending',
    results_title = '',
    layout_config = {
      prompt_position = 'top',
    },
    mappings = {
      i = {
        ['<ESC>'] = actions.close,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<TAB>'] = actions.toggle_selection + actions.move_selection_next,
        ['<C-s>'] = actions.send_selected_to_qflist,
        ['<C-q>'] = actions.send_to_qflist,
        ['<C-h>'] = lactions.toggle_preview,
      },
    },
  },
  pickers = {
    buffers = {
      theme = 'ivy',
      layout_strategy = 'bottom_pane',
      sort_mru = true,
      sort_lastused = true,
      ignore_current_buffer = false,
      previewer = true,
      prompt_title = false,
      layout_config = {
        height = 0.5,
      },
      mappings = {
        i = {
          ['<C-d>'] = actions.delete_buffer,
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
        },
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- "smart_case" | "ignore_case" | "respect_case"
    },
  },
})

local Telescope = setmetatable({}, {
  __index = function(_, k)
    if vim.bo.filetype == 'NvimTree' then
      vim.cmd.wincmd('l')
    end
    return finders[k]
  end,
})

-- Ctrl-p = fuzzy finder
vim.keymap.set('n', '<leader>f', function()
  local ok = pcall(Telescope.git_files, { show_untracked = true })
  if not ok then
    Telescope.find_files()
  end
end)

-- Get :help at the speed of light
vim.keymap.set('n', '<leader>H', Telescope.help_tags)

vim.keymap.set('n', '<leader>P', '<cmd>Telescope projects<cr>')

-- Fuzzy find active buffers
vim.keymap.set('n', '<leader>,', Telescope.buffers)

-- Search for string
vim.keymap.set('n', "'r", Telescope.live_grep)

-- Fuzzy find changed files in git
vim.keymap.set('n', "'c", Telescope.git_status)
