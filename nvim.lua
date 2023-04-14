-- Change leader because reasons
local keyset = vim.keymap.set
vim.g.mapleader = ","
vim.opt.number = true
vim.wo.wrap = false
vim.opt.syntax = "ON"
vim.o.termguicolors = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = false

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
vim.opt.background="dark"

-- coc stuff
vim.opt.shortmess = vim.opt.shortmess + 'c'
vim.opt.hidden = true
vim.opt.cmdheight = 2
vim.opt.updatetime = 300
-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.opt.signcolumn='yes'

-- fix some elixir file associations
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.ex", "*.exs", "mix.lock" },
  command = "setl filetype=elixir"
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.eex", "*.heex", "*.leex", "*.sface", "*.lexs"},
  command = "setl filetype=eelixir"
})

-- easy movement
keyset('n', '<C-j>', '<C-w>j')
keyset('n', '<C-h>', '<C-w>h')
keyset('n', '<C-k>', '<C-w>k')
keyset('n', '<C-l>', '<C-w>l')
keyset('n', '<C-a>', vim.cmd('tabnext'))
keyset('n', '<C-d>', vim.cmd('tabprev'))

-- custom remappings
-- Ctrl-S to save
keyset({ '!', 'n', 'v' }, "<C-s>", "<ESC>:w<CR>")

vim.cmd.highlight('ColorColumn ctermbg=magenta')
vim.opt.colorcolumn = { '+1', 100 }

-- tabwidths and such
vim.opt.shiftwidth=2
