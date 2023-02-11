vim.cmd("autocmd FileType python let b:dispatch = 'python3 %'")

vim.cmd(
  "autocmd FileType cpp let b:dispatch = 'g++ -fsanitize=address -std=c++17 -Wall -Wextra -Wshadow -O2 -o %< % && ./%<'"
)

vim.cmd(
  'autocmd FileType cpp nmap <f10> :Start -wait=always g++ -fsanitize=address -std=c++17 -Wall -Wextra -Wshadow -O2 -o %< % && ./%<<CR>'
)

vim.cmd(
  'autocmd FileType c let b:dispatch = "gcc -fsanitize=address -Wall -Wextra -Wshadow -O2 -o %< % && ./%<"'
)
