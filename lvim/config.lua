-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- general

lvim.log.level = 'info'
lvim.format_on_save = {
  enabled = true,
  pattern = '*.lua',
  timeout = 1000,
}

lvim.leader = 'space'

-- add your own keymapping
lvim.keys.normal_mode['<C-s>'] = ':w<cr>'
lvim.keys.normal_mode['<tab>'] = '<cmd>bn<cr>'
lvim.keys.normal_mode['<s-tab>'] = '<cmd>bp<cr>'
lvim.keys.normal_mode['<s-q>'] = '<cmd>bd<cr>'
lvim.keys.normal_mode['<c-n>'] = '<cmd>NvimTreeToggle<cr>'
lvim.keys.normal_mode['<esc>'] = '<cmd>cclose<cr>'
lvim.keys.normal_mode['<c-t>'] = '<cmd>ToggleTerm<cr>'
lvim.keys.term_mode['<c-t>'] = '<cmd>ToggleTerm<cr>'
lvim.keys.normal_mode['<C-l>'] = '<C-w>l'
lvim.keys.normal_mode['<C-j>'] = '<C-w>j'
lvim.keys.normal_mode['<C-k>'] = '<C-w>k'
lvim.keys.normal_mode['<C-h>'] = '<C-w>h'
lvim.lsp.buffer_mappings.normal_mode['Ï'] = { vim.lsp.buf.format, 'Format' }
lvim.lsp.buffer_mappings.normal_mode['<leader>r'] =
  { vim.lsp.buf.rename, 'Format' }

lvim.keys.insert_mode['<c-l>'] = '<CMD>lua require("luasnip").jump(1)<CR>'
lvim.keys.insert_mode['<c-h>'] = '<CMD>lua require("luasnip").jump(-1)<CR>'

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
lvim.builtin.which_key.mappings['P'] =
  { '<cmd>Telescope projects<CR>', 'Projects' }
lvim.builtin.which_key.mappings['g']['g'] = { '<cmd>G<cr>', 'Fugitive status' }
lvim.builtin.which_key.mappings['c'] = {}

vim.cmd([[
  set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
]])

-- tabcompletion
local cmp = require('cmp')
cmp = require('cmp')
lvim.builtin.cmp.mapping['<c-j>'] = {}
lvim.builtin.cmp.mapping['<c-k>'] = {}
lvim.builtin.cmp.mapping['<Tab>'] = cmp.mapping(function(fallback)
  if cmp.visible() then
    local entry = cmp.get_selected_entry()
    if not entry then
      cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      cmp.confirm()
    else
      cmp.confirm()
    end
  else
    fallback()
  end
end, { 'i', 's' })

-- Change theme settings
lvim.colorscheme = 'tokyonight-night'

-- After changing plugin config exit and reopen LunarVim, Run :PackerSync
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = 'dashboard'
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = 'left'
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.project.detection_methods = { 'pattern', 'lsp' }
lvim.builtin.project.patterns = {
  '.git',
  '.vscode',
  'build',
  '>polykek',
  '>sandbox',
  '>sonartem',
  '>modumlab',
  '_darcs',
  '.hg',
  '.bzr',
  '.svn',
  'Makefile',
  'package.json',
  '.stylua.toml',
}

lvim.builtin.telescope.file_ignore_patterns = { 'build' }

lvim.builtin.lualine.options.theme = 'tokyonight'

lvim.builtin.alpha.dashboard.section.header.val = {
  '',
  '⡿⠋⠄⣀⣀⣤⣴⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣌⠻⣿⣿',
  '⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠹⣿',
  '⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠹',
  '⣿⣿⡟⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡛⢿⣿⣿⣿⣮⠛⣿⣿⣿⣿⣿⣿⡆',
  '⡟⢻⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣣⠄⡀⢬⣭⣻⣷⡌⢿⣿⣿⣿⣿⣿',
  '⠃⣸⡀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠈⣆⢹⣿⣿⣿⡈⢿⣿⣿⣿⣿',
  '⠄⢻⡇⠄⢛⣛⣻⣿⣿⣿⣿⣿⣿⣿⣿⡆⠹⣿⣆⠸⣆⠙⠛⠛⠃⠘⣿⣿⣿⣿',
  '⠄⠸⣡⠄⡈⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠁⣠⣉⣤⣴⣿⣿⠿⠿⠿⡇⢸⣿⣿⣿',
  '⠄⡄⢿⣆⠰⡘⢿⣿⠿⢛⣉⣥⣴⣶⣿⣿⣿⣿⣻⠟⣉⣤⣶⣶⣾⣿⡄⣿⡿⢸',
  '⠄⢰⠸⣿⠄⢳⣠⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣼⣿⣿⣿⣿⣿⣿⡇⢻⡇⢸',
  '⢷⡈⢣⣡⣶⠿⠟⠛⠓⣚⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⢸⠇⠘',
  '⡀⣌⠄⠻⣧⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠛⠛⠛⢿⣿⣿⣿⣿⣿⡟⠘⠄⠄',
  '⣷⡘⣷⡀⠘⣿⣿⣿⣿⣿⣿⣿⣿⡋⢀⣠⣤⣶⣶⣾⡆⣿⣿⣿⠟⠁⠄⠄⠄⠄',
  '⣿⣷⡘⣿⡀⢻⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣿⣿⣿⣿⣷⡿⠟⠉⠄⠄⠄⠄⡄⢀',
  '⣿⣿⣷⡈⢷⡀⠙⠛⠻⠿⠿⠿⠿⠿⠷⠾⠿⠟⣛⣋⣥⣶⣄⠄⢀⣄⠹⣦⢹⣿',
}

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
--
require('lvim.lsp.manager').setup('omnisharp', {
  cmd = {
    '/Users/artemson/.local/share/nvim/mason/bin/omnisharp-mono',
  },

  -- Enables support for reading code style, naming convention and analyzer
  -- settings from .editorconfig.
  enable_editorconfig_support = true,

  -- If true, MSBuild project system will only load projects for files that
  -- were opened in the editor. This setting is useful for big C# codebases
  -- and allows for faster initialization of code navigation features only
  -- for projects that are relevant to code that is being edited. With this
  -- setting enabled OmniSharp may load fewer projects and may thus display
  -- incomplete reference lists for symbols.
  enable_ms_build_load_projects_on_demand = false,

  -- Enables support for roslyn analyzers, code fixes and rulesets.
  enable_roslyn_analyzers = false,

  -- Specifies whether 'using' directives should be grouped and sorted during
  -- document formatting.
  organize_imports_on_format = false,

  -- Enables support for showing unimported types and unimported extension
  -- methods in completion lists. When committed, the appropriate using
  -- directive will be added at the top of the current file. This option can
  -- have a negative impact on initial completion responsiveness,
  -- particularly for the first few completion sessions after opening a
  -- solution.
  enable_import_completion = true,

  -- Specifies whether to include preview versions of the .NET SDK when
  -- determining which version to use for project loading.
  sdk_include_prereleases = true,

  -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
  -- true
  analyze_open_documents_only = false,
})

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require('lvim.lsp.null-ls.formatters')
formatters.setup({
  { command = 'stylua' },
  { command = 'prettier' },
  { command = 'black' },
})
local linters = require('lvim.lsp.null-ls.linters')
linters.setup({
  { command = 'flake8', filetypes = { 'python' } },
  {
    command = 'shellcheck',
    args = { '--severity', 'warning' },
  },
})

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
  { 'tpope/vim-fugitive' },
  {
    'folke/trouble.nvim',
    cmd = 'TroubleToggle',
  },
  {
    'christoomey/vim-tmux-navigator',
    config = function()
      vim.g.tmux_navigator_save_on_switch = 2
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
  },
  {
    'karb94/neoscroll.nvim',
    event = 'WinScrolled',
    config = function()
      require('neoscroll').setup({ hide_cursor = false })
    end,
  },
  {
    'Shatur/neovim-cmake',
    config = function()
      local Path = require('plenary.path')
      Progress = ''

      require('cmake').setup({
        cmake_executable = 'cmake', -- CMake executable to run.
        save_before_build = true, -- Save all buffers before building.
        parameters_file = 'neovim.json', -- JSON file to store information about selected target, run arguments and build type.
        default_parameters = { args = {}, build_type = 'Debug' }, -- The default values in `parameters_file`. Can also optionally contain `run_dir` with the working directory for applications.
        build_dir = tostring(Path:new('{cwd}', 'build')), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
        default_projects_path = tostring(
          Path:new(vim.loop.os_homedir(), 'CmakeProjects')
        ), -- Default folder for creating project.
        configure_args = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1' }, -- Default arguments that will be always passed at cmake configure step. By default tells cmake to generate `compile_commands.json`.
        build_args = {}, -- Default arguments that will be always passed at cmake build step.
        on_build_output = function(lines)
          -- Get only last line
          local match = string.match(lines[#lines], '(%[.*%])')
          if match then
            Progress = string.gsub(match, '%%', '%%%%')
          end
        end,
        quickfix = {
          pos = 'botright', -- Where to open quickfix
          height = 5, -- Height of the opened quickfix.
          only_on_error = false, -- Open quickfix window only if target build failed.
        },
        copy_compile_commands = true, -- Copy compile_commands.json to current working directory.
        dap_configurations = { -- Table of different DAP configurations.
          lldb_vscode = { type = 'lldb', request = 'launch' },
          cppdbg_vscode = { type = 'cppdbg', request = 'launch' },
        },
        dap_configuration = 'lldb_vscode', -- DAP configuration to use if the projects `parameters_file` does not specify one.
        dap_open_command = function(...)
          require('dap').repl.open(...)
        end, -- Command to run after starting DAP session. You can set it to `false` if you don't want to open anything or `require('dapui').open` if you are using https://github.com/rcarriga/nvim-dap-ui
      })

      vim.keymap.set('n', '<leader>cg', '<CMD>CMake<CR>')
      vim.keymap.set('n', '<leader>cb', '<CMD>CMake build_all<CR>')
      vim.keymap.set('n', '<leader>cr', '<CMD>CMake build_and_run<CR>')
    end,
  },
}
