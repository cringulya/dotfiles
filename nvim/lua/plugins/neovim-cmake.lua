local Path = require('plenary.path')
Progress = ""

require('cmake').setup({
  cmake_executable = 'cmake', -- CMake executable to run.
  save_before_build = true, -- Save all buffers before building.
  parameters_file = 'neovim.json', -- JSON file to store information about selected target, run arguments and build type.
  default_parameters = { args = {}, build_type = 'Debug' }, -- The default values in `parameters_file`. Can also optionally contain `run_dir` with the working directory for applications.
  build_dir = tostring(Path:new('{cwd}', 'build')), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
  default_projects_path = tostring(Path:new(vim.loop.os_homedir(), 'CmakeProjects')), -- Default folder for creating project.
  configure_args = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1' }, -- Default arguments that will be always passed at cmake configure step. By default tells cmake to generate `compile_commands.json`.
  build_args = {}, -- Default arguments that will be always passed at cmake build step.
  on_build_output = function(lines)
    -- Get only last line
    local match = string.match(lines[#lines], "(%[.*%])")
    if match then
      Progress = string.gsub(match, "%%", "%%%%")
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
  dap_open_command = function(...) require('dap').repl.open(...) end, -- Command to run after starting DAP session. You can set it to `false` if you don't want to open anything or `require('dapui').open` if you are using https://github.com/rcarriga/nvim-dap-ui
})

vim.keymap.set('n', '<leader>cg', '<CMD>CMake<CR>')
vim.keymap.set('n', '<leader>cb', '<CMD>CMake build_all<CR>')
vim.keymap.set('n', '<leader>cr', '<CMD>CMake run<CR>')
