-- Change leader because reasons
vim.g.mapleader = ","
vim.g.dap_virtual_text = true
vim.opt.number = true
vim.wo.wrap = false
vim.opt.syntax = "ON"
vim.o.termguicolors = true
vim.o.foldenable = false

vim.cmd.highlight("ColorColumn ctermbg=magenta")
vim.opt.colorcolumn = { "+1", 100 }

-- tabwidths and such
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8

vim.opt.updatetime = 50
-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.opt.signcolumn = "yes"
-- fix some elixir file associations
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   pattern = { "*.ex", "*.exs", "mix.lock" },
--   command = "set filetype=elixir"
-- })
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   pattern = { "*.eex", "*.heex", "*.leex", "*.sface", "*.lexs" },
--   command = "set filetype=eelixir"
-- })
