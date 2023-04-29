-- easy movement
local keyset = vim.keymap.set
keyset('n', '<C-j>', '<C-w>j')
keyset('n', '<C-h>', '<C-w>h')
keyset('n', '<C-k>', '<C-w>k')
keyset('n', '<C-l>', '<C-w>l')
keyset('n', '<C-a>', vim.cmd('tabnext'))
keyset('n', '<C-d>', vim.cmd('tabprev'))

-- custom remappings
-- Ctrl-S to save
keyset({ '!', 'n', 'v' }, "<C-s>", "<ESC>:w<CR>")

