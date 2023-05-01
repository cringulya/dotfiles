local icons = require('icons')

require('nvim-tree').setup({

  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_cwd = true,
  diagnostics = {
    enable = true,
    icons = {
      hint = icons.diagnostics.BoldHint,
      info = icons.diagnostics.BoldInformation,
      warning = icons.diagnostics.BoldWarning,
      error = icons.diagnostics.BoldError,
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    update_root = true,
  },
  view = {
    width = 30,
    side = 'left',
    mappings = {
      list = {
        { key = 'l', action = 'edit', mode = 'n' },
        { key = 'h', action = 'close_node', mode = 'n' },
        { key = 'C', action = 'cd', mode = 'n' },
      },
    },
  },
  filters = {
    custom = { '.git$', 'node_modules$', '^target$', '*.meta', '__pycache__' },
  },
  git = {
    enable = true,
    ignore = false,
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = false,
      icons = {
        corner = '└',
        edge = '│',
        item = '│',
        none = ' ',
      },
    },
    icons = {
      webdev_colors = true,
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
      glyphs = {
        default = icons.ui.Text,
        symlink = icons.ui.FileSymlink,
        git = {
          deleted = icons.git.FileDeleted,
          ignored = icons.git.FileIgnored,
          renamed = icons.git.FileRenamed,
          staged = icons.git.FileStaged,
          unmerged = icons.git.FileUnmerged,
          unstaged = icons.git.FileUnstaged,
          untracked = icons.git.FileUntracked,
        },
        folder = {
          default = icons.ui.Folder,
          empty = icons.ui.EmptyFolder,
          empty_open = icons.ui.EmptyFolderOpen,
          open = icons.ui.FolderOpen,
          symlink = icons.ui.FolderSymlink,
        },
      },
    },
    highlight_git = true,
    group_empty = false,
    root_folder_modifier = ':t',
  },
})

vim.keymap.set('n', '<C-n>', '<CMD>NvimTreeToggle<CR>')

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('NVIM_TREE', { clear = true }),
  pattern = 'NvimTree',
  callback = function()
    vim.api.nvim_win_set_option(0, 'wrap', false)
  end,
})
