vim.keymap.set('n', '`<cr>', ':RunCode<CR>', { noremap = true, silent = false })

require('code_runner').setup({
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
})
