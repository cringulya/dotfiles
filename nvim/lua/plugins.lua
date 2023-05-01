local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'folke/tokyonight.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      require('tokyonight').setup({
        style = 'night',
        on_colors = function(colors)
          colors.border = '#FFA500'
        end,
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  { 'folke/neodev.nvim', lazy = true },

  {
    'folke/which-key.nvim',
    event = 'BufWinEnter',
    config = function()
      require('plugins.which-key').setup()
    end,
  },

  {
    'nvim-lua/plenary.nvim',
    dependencies = {
      {
        'CRAG666/code_runner.nvim',
        event = 'BufRead',
        config = function()
          require('plugins.code_runner')
        end,
      },
    },
  },

  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('plugins.dashboard-nvim')
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },

  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
  },

  {
    'nvim-lualine/lualine.nvim',
    event = 'BufEnter',
    config = function()
      require('plugins.lualine').setup()
    end,
  },

  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('plugins.nvim-tree')
    end,
  },

  {
    'karb94/neoscroll.nvim',
    event = 'WinScrolled',
    config = function()
      require('neoscroll').setup({ hide_cursor = false })
    end,
  },

  --------------------------
  -- Editor UI Niceties --
  --------------------------

  { 'stevearc/dressing.nvim', event = 'VeryLazy' },

  {
    'christoomey/vim-tmux-navigator',
    event = 'VimEnter',
    config = function()
      vim.g.tmux_navigator_save_on_switch = 2
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufRead',
    config = function()
      require('plugins.indentline')
    end,
  },

  {
    'norcalli/nvim-colorizer.lua',
    event = 'CursorHold',
    config = function()
      require('colorizer').setup()
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = function()
      require('plugins.gitsigns')
    end,
  },

  {
    'tpope/vim-fugitive',
  },

  {
    'rhysd/git-messenger.vim',
    event = 'BufRead',
    config = function()
      require('plugins.git-messenger')
    end,
  },

  {
    'numToStr/Comment.nvim',
    event = 'BufRead',
    config = function()
      require('Comment').setup()
    end,
  },

  {
    'tpope/vim-repeat',
    event = 'BufRead',
    dependencies = {
      {
        'tpope/vim-surround',
        event = 'BufRead',
      },
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    event = 'CursorHold',
    config = function()
      require('plugins.telescope')
    end,
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
          require('telescope').load_extension('fzf')
        end,
      },

      { 'nvim-telescope/telescope-symbols.nvim' },

      {
        'ahmedkhalf/project.nvim',
        config = function()
          require('plugins.project')
          require('telescope').load_extension('projects')
        end,
      },
    },
  },

  --------------
  -- Terminal --
  --------------

  -- {
  --   'akinsho/toggleterm.nvim',
  --   config = function()
  --     require('plugins.term')
  --   end,
  -- },

  -----------------------------------
  -- LSP, Completions and Snippets --
  -----------------------------------

  {
    'williamboman/mason.nvim',
    dependencies = {
      {
        'williamboman/mason-lspconfig.nvim',
        config = function()
          require('mason-lspconfig').setup()
        end,
      },
    },
    config = function()
      require('mason').setup()
    end,
  },

  {
    'SmiteshP/nvim-navic',
    config = function()
      require('plugins.breadcrumps').setup()
    end,
  },

  {
    'neovim/nvim-lspconfig',
    event = 'BufRead',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    config = function()
      require('lsp.servers')
    end,
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufRead',
    config = function()
      require('lsp.null-ls')
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'BufRead',
    config = function()
      require('lsp.nvim-cmp')
    end,
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require('lsp.luasnip')
        end,
        dependencies = {
          { 'rafamadriz/friendly-snippets' },
        },
      },
      {
        'windwp/nvim-autopairs',
        event = 'InsertCharPre',
        config = function()
          require('plugins.pairs')
        end,
      },
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
    },
  },

  -- SchemaStore
  {
    'b0o/schemastore.nvim',
    lazy = true,
  },

  ------------------
  -------CODE------
  ------------------

  {
    'AckslD/swenv.nvim',
    config = function()
      require('swenv').setup({
        -- Should return a list of tables with a `name` and a `path` entry each.
        -- Gets the argument `venvs_path` set below.
        -- By default just lists the entries in `venvs_path`.
        get_venvs = function(venvs_path)
          return require('swenv.api').get_venvs(venvs_path)
        end,
        -- Path passed to `get_venvs`.
        venvs_path = vim.fn.expand('~/.virtualenvs'),
        -- Something to do after setting an environment
        post_set_venv = function()
          vim.cmd([[
          :LspRestart<cr>
          ]])
        end,
      })
    end,
  },

  {
    'Shatur/neovim-cmake',
    config = function()
      require('plugins.neovim-cmake')
    end,
  },

  { 'ianding1/leetcode.vim' },

  {
    'andymass/vim-matchup',
    event = 'BufRead',
    config = function()
      vim.keymap.set({ 'n', 'x', 'o' }, '<TAB>', '<plug>(matchup-%)')
      vim.keymap.set({ 'x', 'o' }, 'i<TAB>', '<plug>(matchup-i%)')
      vim.keymap.set({ 'x', 'o' }, 'o<TAB>', '<plug>(matchup-o%)')
      vim.g.matchup_override_vimtex = 1
    end,
  },

  {
    'akinsho/bufferline.nvim',
    config = function()
      require('plugins.bufferline')
    end,
    branch = 'main',
    event = 'BufWinEnter',
  },

  {
    'RRethy/vim-illuminate',
    config = function()
      require('plugins.illuminate')
    end,
  },

  {
    'lervag/vimtex',
    ft = 'tex',
    config = function()
      vim.cmd([[
        let g:vimtex_mappings_prefix = "\l"
        let g:vimtex_compiler_latexmk = {
            \ 'build_dir' : './build',
        \}
      ]])
    end,
  },

  -----------------------------------
  -- Treesitter: Better Highlights --
  -----------------------------------

  {
    {
      'nvim-treesitter/nvim-treesitter',
      event = 'CursorHold',
      run = ':TSUpdate',
      config = function()
        require('plugins.treesitter')
      end,
      dependencies = {
        { 'nvim-treesitter/playground' },
        { 'nvim-treesitter/nvim-treesitter-textobjects' },
        { 'nvim-treesitter/nvim-treesitter-refactor' },
        { 'windwp/nvim-ts-autotag' },
        { 'JoosepAlviste/nvim-ts-context-commentstring' },
        { 'p00f/nvim-ts-rainbow' },
      },
    },
  },
})
