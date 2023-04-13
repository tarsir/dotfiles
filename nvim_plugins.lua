return {
  { 'neoclide/coc.nvim', branch = 'release'},
  { 'elixir-lsp/coc-elixir', build = 'yarn install && yarn prepack'},
  { 'folke/which-key.nvim', lazy = true},
  'neoclide/coc-rls',
  'fannheyward/coc-rust-analyzer',

  'roxma/nvim-yarp',
  'honza/vim-snippets',

  -- General vim plugins,
  'dense-analysis/ale',
  'godlygeek/tabular',
  'junegunn/fzf',
  'junegunn/vim-easy-align',
  'tpope/vim-commentary',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'tpope/vim-fugitive',
  'scrooloose/nerdtree',
  'scrooloose/syntastic',
  'rking/ag.vim',
  'junegunn/fzf',

  -- Color schemes and aesthetics,
  'altercation/vim-colors-solarized',
  { 'morhetz/gruvbox', lazy = false},

  -- language specifics,
  'elixir-editors/vim-elixir',
  'rust-lang/rust.vim',
  'plasticboy/vim-markdown',
  'ziglang/zig.vim',
}
