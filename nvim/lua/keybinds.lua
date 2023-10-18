local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

-- -- Terminal
--
-- map('n', '<C-t>', '<cmd>split term<cr>i')

-- Move to the next/previous buffer
-- map('n', '<TAB>', '<CMD>bn<CR>')
-- map('n', '<s-TAB>', '<CMD>bp<CR>')
map('n', 'Q', '<CMD>bd!<CR>')
map('n', '<leader>bk', '<CMD>bd!<CR>')
map('n', 'H', '0')
map('n', 'L', '$')

-- reload config
map('n', '<leader>uc', '<CMD>source ~/.config/nvim/init.lua<CR>')

-- Copying the vscode behaviour of making tab splits
map('n', '<C-\\>', '<CMD>vsplit<CR>')

-- Terminal to normal mode
map('t', '<ESC>', '<C-\\><C-n><CR>')

-- Maps this in tmux-navigator plugin
-- map('n', '<C-j>', '<C-w>j')
-- map('n', '<C-k>', '<C-w>k')
-- map('n', '<C-l>', '<C-w>l')
-- map('n', '<C-h>', '<C-w>h')
--
map('n', '<ESC>', '<CMD>cclose<CR><CMD>NvimTreeClose<CR>')
-- map('n', 'q', '<cmd>cclose<cr>')

vim.cmd([[
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <silent> <c-q> :call ToggleQuickFix()<CR>
]])

vim.cmd([[
  set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
]])

map('n', ':й', ':q')
