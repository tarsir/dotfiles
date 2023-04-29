-- Change leader because reasons
vim.g.mapleader = ","
vim.opt.number = true
vim.wo.wrap = false
vim.opt.syntax = "ON"
vim.o.termguicolors = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = false

vim.cmd.highlight('ColorColumn ctermbg=magenta')
vim.opt.colorcolumn = { '+1', 100 }

-- tabwidths and such
vim.opt.shiftwidth=2

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
