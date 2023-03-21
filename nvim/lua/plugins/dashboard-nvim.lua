local db = require('dashboard')

local dashboard_custom_header4 = {
  '',
  '',
  '',
  '',
  '██╗░░██╗███████╗███╗░░██╗████████╗░█████╗░██╗',
  '██║░░██║██╔════╝████╗░██║╚══██╔══╝██╔══██╗██║',
  '███████║█████╗░░██╔██╗██║░░░██║░░░███████║██║',
  '██╔══██║██╔══╝░░██║╚████║░░░██║░░░██╔══██║██║',
  '██║░░██║███████╗██║░╚███║░░░██║░░░██║░░██║██║',
  '╚═╝░░╚═╝╚══════╝╚═╝░░╚══╝░░░╚═╝░░░╚═╝░░╚═╝╚═╝',
  '',
  '',
  '',
  '',
  '',
}

local dashboard_custom_header18 = {
  '',
  '⣿⣿⠏⣠⣾⣦⡐⢌⢿⣷⣦⣅⡑⠕⠡⠐⢿⠿⣛⠟⠛⠛⠛⠛⠡⢷⡈⢂⢕⢂⣛⡓⣉⠉⠙⠻⢿⣿⣿⣟⣻⠿⣹⡏⣿⣿⣧⢸⣧⣿⣿⣨⡟⣿⣿⣿⣿',
  '⠟⣡⣾⣿⣿⣿⣿⣦⣑⠝⢿⣿⣿⣿⣿⣿⡵⢁⣤⣶⣶⣿⢿⢿⢿⡟⢻⣤⢑⢂⠸⣷⣹⣿⠄⠄⠄⠄⠘⢿⣿⣿⣯⣳⣿⣭⣽⢼⣿⣜⣿⣇⣷⡹⣿⣿⣿',
  '⣾⣿⣿⡿⢟⣛⣻⣿⣿⣿⣦⣬⣙⣻⣿⣿⣷⣿⣿⢟⢝⢕⢕⢕⢕⢽⣿⣿⣷⣔⠄⢻⣷⣿⡄⢈⠿⠇⢸⣿⣿⣿⣿⣿⣿⣟⠛⠲⢯⣿⣒⡾⣼⣷⡹⣿⣿',
  '⣿⣿⠵⠚⠉⢀⣀⣀⣈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣗⢕⢕⢕⢕⢕⢕⣽⣿⣿⣿⣿⡄⢸⣿⣿⣷⣬⣽⣯⣾⣿⣿⣿⣿⣿⣿⣿⣿⡀⠄⢀⠉⠙⠛⠛⠳⠽⠿',
  '⢷⣂⣠⣴⣾⡿⡿⡻⡻⣿⣿⣴⣿⣿⣿⣿⣿⣿⣷⣵⣵⣵⣷⣿⣿⣿⣿⣿⣿⡿⡇⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⢄⣹⡿⠃⠄⠄⣰⠎⡈',
  '⢌⠻⣿⡿⡫⡪⡪⡪⡪⣺⣿⣿⣿⣿⣿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⡇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣭⣽⣖⣄⣴⣯⣾⢷',
  '⠣⡁⠹⡪⡪⡪⡪⣪⣾⣿⣿⣿⣿⠋⠐⢉⢍⢄⢌⠻⣿⣿⣿⣿⣿⣿⣿⣿⠏⠈⣧⠸⣿⣿⣿⣿⣿⣿⠯⠊⠙⢻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⣾',
  '⡣⡘⢄⠙⣾⣾⣾⣿⣿⣿⣿⣿⣿⡀⢐⢕⢕⢕⢕⢕⡘⣿⣿⣿⣿⣿⣿⠏⠠⠈⣿⣦⠹⣿⣿⣿⣿⣿⠄⢀⣴⢾⣼⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣾⣿',
  '⠌⢊⢂⢣⠹⣿⣿⣿⣿⣿⣿⣿⣿⣧⢐⢕⢕⢕⢕⢕⢅⣿⣿⣿⣿⡿⢋⢜⠠⠈⣿⣿⣇⢽⣿⣿⣿⡏⣿⣿⣿⣿⣿⡇⣿⣿⣿⣿⡿⣿⣛⣻⠿⣟⣼⣿⣿',
  '⠄⠁⠕⢝⡢⠈⠻⣿⣿⣿⣿⣿⣿⣿⣷⣕⣑⣑⣑⣵⣿⣿⣿⡿⢋⢔⢕⣿⠠⠈⣿⣿⣿⡎⣷⣽⠻⣇⣿⣿⣿⡿⣟⣵⣿⣟⣽⣾⣿⣿⣿⣿⢯⣾⣿⣿⣿',
  '',
}

db.setup({
  theme = 'doom',
  disable_move = true, --  defualt is false disable move keymap for hyper
  shortcut_type = 'number',

  --hyper
  -- config = {
  --   week_header = {
  --     enable = true,
  --   },
  --   shortcut = {
  --     {
  --       desc = ' Update',
  --       group = '@property',
  --       action = 'Lazy update',
  --       key = 'u',
  --     },
  --     {
  --       icon = ' ',
  --       icon_hl = '@variable',
  --       desc = 'Files',
  --       group = 'Label',
  --       action = 'Telescope find_files',
  --       key = 'f',
  --     },
  --     {
  --       desc = ' Projects',
  --       group = 'DiagnosticHint',
  --       action = 'Telescope projects',
  --       key = 'p',
  --     },
  --     {
  --       desc = ' dotfiles',
  --       group = 'Number',
  --       action = 'Telescope find_files cwd=~/.config/nvim/',
  --       key = 'd',
  --     },
  --   },
  --   packages = { enable = false },
  --   mru = {
  --     limit = 8,
  --   },
  --   project = {
  --     enable = false,
  --     limit = 2,
  --   },
  --   footer = {},
  -- },

  -- doom
  config = {
    header = dashboard_custom_header4,
    week_header = {
      enable = false,
    },
    center = {
      {
        icon = '',
        icon_hl = 'number',
        desc = 'recent',
        desc_hl = 'group',
        key = 'r',
        key_hl = 'group',
        action = 'Telescope oldfiles',
      },
      {
        icon = '',
        icon_hl = 'group',
        desc = 'projects',
        desc_hl = 'group',
        key = 'p',
        key_hl = 'group',
        action = 'Telescope projects',
      },
      {
        icon = '',
        icon_hl = 'group',
        desc = 'dotfiles',
        desc_hl = 'group',
        key = 'd',
        key_hl = 'group',
        action = 'Telescope find_files cwd=~/.config/nvim',
      },
    },
    footer = {},
  },
})
