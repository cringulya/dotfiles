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
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup()
    end,
  })

  use({ 'numToStr/Sakura.nvim' })
  use({ 'laniusone/kyotonight.vim' })

  use({
    {
      'nvim-lualine/lualine.nvim',
      after = 'Sakura.nvim',
      event = 'BufEnter',
      config = function()
        require('plugins.lualine')
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

  use({
    'glepnir/dashboard-nvim',
    config = function()
      require('plugins.dashboard-nvim')
    end,
  })

  use({ 'luochen1990/rainbow' })

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
    { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
    { 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' },
    { 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' },
    { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' },
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

  use({
    'dinhhuy258/git.nvim',
    config = function()
      require('plugins.git')
    end,
  })

  use({
    'rhysd/git-messenger.vim',
    event = 'BufRead',
    config = function()
      require('plugins.git-messenger')
    end,
  })

  use({
    'gelguy/wilder.nvim',
    config = function()
      require('plugins.wilder')
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
      require('plugins.lsp.servers')
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
      require('plugins.lsp.null-ls')
    end,
  })

  use({
    {
      'hrsh7th/nvim-cmp',
      config = function()
        require('plugins.lsp.nvim-cmp')
      end,
      requires = {
        {
          'L3MON4D3/LuaSnip',
          config = function()
            require('plugins.lsp.luasnip')
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

  ------------------
  -------C/C++------
  ------------------

  use({
    'Shatur/neovim-cmake',
    config = function()
      require('plugins.neovim-cmake')
    end,
  })
end)
