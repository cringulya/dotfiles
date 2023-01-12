-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerCompile',
})

return require('packer').startup(function(use)
  ---------------------
  -- Package Manager --
  ---------------------

  use('wbthomason/packer.nvim')

  use('nvim-lua/plenary.nvim')

  ----------------------------------------
  -- Theme, Icons, Statusbar, Bufferbar --
  ----------------------------------------

  use({
    'folke/tokyonight.nvim',
    config = function()
      require('tokyonight').setup({ style = 'night' })
    end,
  })

  use({ 'numToStr/Sakura.nvim' })

  use({
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup()
    end,
  })

  use({
    'glepnir/dashboard-nvim',
    config = function()
      require('plugins.dashboard-nvim')
    end,
  })

  use({
    {
      'nvim-lualine/lualine.nvim',
      after = 'Sakura.nvim',
      event = 'BufEnter',
      config = function()
        require('plugins.lualine').setup()
      end,
    },
    {
      'j-hui/fidget.nvim',
      after = 'lualine.nvim',
      config = function()
        require('fidget').setup()
      end,
    },
  })

  use({
    'nvim-tree/nvim-tree.lua',
    event = 'CursorHold',
    config = function()
      require('plugins.nvim-tree')
    end,
  })

  use({
    'karb94/neoscroll.nvim',
    event = 'WinScrolled',
    config = function()
      require('neoscroll').setup({ hide_cursor = false })
    end,
  })

  -----------------------------------
  -- Treesitter: Better Highlights --
  -----------------------------------

  use({
    {
      'nvim-treesitter/nvim-treesitter',
      event = 'CursorHold',
      run = ':TSUpdate',
      config = function()
        require('plugins.treesitter')
      end,
    },
    { 'nvim-treesitter/playground', after = 'nvim-treesitter' },
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      after = 'nvim-treesitter',
    },
    { 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' },
    { 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' },
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      after = 'nvim-treesitter',
    },
    {
      'p00f/nvim-ts-rainbow',
      after = 'nvim-treesitter',
    },
  })

  --------------------------
  -- Editor UI Niceties --
  --------------------------

  use({
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufRead',
    config = function()
      require('plugins.indentline')
    end,
  })

  use({
    'norcalli/nvim-colorizer.lua',
    event = 'CursorHold',
    config = function()
      require('colorizer').setup()
    end,
  })

  use({
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = function()
      require('plugins.gitsigns')
    end,
  })

  use({ 'tpope/vim-fugitive' })

  use({
    'rhysd/git-messenger.vim',
    event = 'BufRead',
    config = function()
      require('plugins.git-messenger')
    end,
  })

  use({
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  })

  use({
    'tpope/vim-surround',
    event = 'BufRead',
    requires = {
      {
        'tpope/vim-repeat',
        event = 'BufRead',
      },
    },
  })

  use({
    {
      'nvim-telescope/telescope.nvim',
      event = 'CursorHold',
      config = function()
        require('plugins.telescope')
      end,
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      after = 'telescope.nvim',
      run = 'make',
      config = function()
        require('telescope').load_extension('fzf')
      end,
    },
    {
      'nvim-telescope/telescope-symbols.nvim',
      after = 'telescope.nvim',
    },
  })

  --------------
  -- Terminal --
  --------------

  use({
    'numToStr/FTerm.nvim',
    event = 'CursorHold',
    config = function()
      require('plugins.fterm')
    end,
  })

  -----------------------------------
  -- LSP, Completions and Snippets --
  -----------------------------------

  use({
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  })

  use({
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup()
    end,
  })

  use({
    'neovim/nvim-lspconfig',
    event = 'BufRead',
    config = function()
      require('lsp.servers')
    end,
    requires = {
      {
        -- WARN: Unfortunately we won't be able to lazy load this
        'hrsh7th/cmp-nvim-lsp',
      },
    },
  })

  use({
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufRead',
    config = function()
      require('lsp.null-ls')
    end,
  })

  use({
    {
      'hrsh7th/nvim-cmp',
      config = function()
        require('lsp.nvim-cmp')
      end,
      requires = {
        {
          'L3MON4D3/LuaSnip',
          config = function()
            require('lsp.luasnip')
          end,
          requires = {
            {
              'rafamadriz/friendly-snippets',
            },
          },
        },
      },
    },
    { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
  })

  use({
    'windwp/nvim-autopairs',
    event = 'InsertCharPre',
    after = 'nvim-cmp',
    config = function()
      require('plugins.pairs')
    end,
  })

  use({
    'tpope/vim-dispatch',
    config = function()
      require('plugins.vim-dispatch')
    end,
  })

  use({
    'christoomey/vim-tmux-navigator',
    config = function()
      vim.g.tmux_navigator_save_on_switch = 2
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
  })

  ------------------
  -------C/C++------
  ------------------

  use({
    'Shatur/neovim-cmake',
    config = function()
      require('plugins.neovim-cmake')
    end,
  })

  -- lvim
  -- use({
  --   'christianchiarulli/lir.nvim',
  --   config = function()
  --     require('plugins.lir')
  --   end,
  --   requires = { 'kyazdani42/nvim-web-devicons' },
  -- })

  use({
    'folke/which-key.nvim',
    config = function()
      require('plugins.which-key').setup()
    end,
    event = 'BufWinEnter',
  })
  use( -- project.nvim
    {
      'ahmedkhalf/project.nvim',
      config = function()
        require('plugins.project')
        require('telescope').load_extension('projects')
      end,
      after = 'telescope.nvim',
    }
  )

  use({
    'akinsho/bufferline.nvim',
    config = function()
      require('plugins.bufferline')
    end,
    branch = 'main',
    event = 'BufWinEnter',
  })

  -- SchemaStore
  use({
    'b0o/schemastore.nvim',
  })

  use({
    'RRethy/vim-illuminate',
    config = function()
      require('plugins.illuminate')
    end,
  })

  -- Markdown
  use({
    'iamcco/markdown-preview.nvim',
    run = function()
      vim.fn['mkdp#util#install']()
    end,
  })
  --
  use({
    'SmiteshP/nvim-navic',
    requires = 'neovim/nvim-lspconfig',
    config = function()
      require('plugins.breadcrumps').setup()
    end,
  })
end)
