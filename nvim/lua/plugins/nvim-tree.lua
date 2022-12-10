require('nvim-tree').setup({

  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  diagnostics = {
    enable = true,
  },
  update_focused_file = {
    enable = true,
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
    custom = { '.git$', 'node_modules$', '^target$', '*.meta' },
  },
  git = {
    ignore = false,
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
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
