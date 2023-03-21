vim.keymap.set('n', '`<cr>', ':RunCode<CR>', { noremap = true, silent = true })

require('code_runner').setup({
  -- mode = 'toggleterm',
  mode = 'toggle',
  float = {
    border = 'rounded',
    height = 1,
    width = 1,
  },
  startinsert = true,
  -- put here the commands by filetype
  filetype = {
    java = 'cd $dir && javac $fileName && java $fileNameWithoutExt',
    python = 'python3 $dir/$fileName',
    typescript = 'deno run',
    rust = 'cd $dir && rustc $fileName && $dir/$fileNameWithoutExt',
    cpp = 'cd $dir && mkdir -p build && g++ -fsanitize=address -std=c++17 -Wall -Wextra -Wshadow -O2 -o ./build/$fileNameWithoutExt $fileName && ./build/$fileNameWithoutExt',
    c = 'cd $dir && mkdir -p build && gcc -fsanitize=address -Wall -Wextra -Wshadow -O2 -o ./build/$fileNameWithoutExt $fileName && ./build/$fileNameWithoutExt',
  },

  project_path = vim.fn.expand('~/.config/nvim/project_manager.json'),
})
