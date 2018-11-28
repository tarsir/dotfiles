let g:config_file = "~/.nvim/nvimrc"
let g:plugin_directory = "~/.nvim/pluggo"
let g:has_started = 0
let mapleader = ","

" initial startup stuff
if g:has_started == 0
	let g:has_started = 1
	cd ~/Development
end

" Plug configuration
call plug#begin(g:plugin_directory)

Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'kien/ctrlp.vim'
Plug 'jeetsukumaran/vim-buffergator'

""" Language specific
" Elixir
Plug 'elixir-lang/vim-elixir'
Plug 'mattonrails/vim-mix'
Plug 'slashmili/alchemist.vim'

call plug#end()

" aliases/remappings

map <leader>f :exec "source " . g:config_file<CR>

map <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>

" motion
map <C-j> <C-w>j
map <C-h> <C-w>h
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-a> :tabprevious<CR>
map <C-d> :tabnext<CR>

" plugin specific
map <leader>bg :BuffergatorToggle<CR>
map <C-n> :NERDTreeToggle<CR>

map <leader>gs :Gstatus<CR>
map <leader>gc :Gcommit --verbose<CR>
map <leader>go :Git checkout -- %:p<CR>
map <leader>gp :Gpull<CR>
nnoremap <leader>ga :Git add %:p<CR>:q<CR>


""" Plugin Settings
" Ctrl-P
let g:ctrlp_custom_ignore = {
	\ 'dir' : '\v[\/]((\.(git|hg|svn))|(bower_components|node_modules|vendor|pluggo|deps|_build|doc|tmp))$',
	\ 'file' : '\v\.((pyc)|(min\.js)|(jpg|png|gif|bmp))$'
	\ }

" Sensible defaults for me :>
colorscheme gruvbox
set termguicolors

set background=dark
set nowrap
set number
set expandtab


""" Filetype etc.
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType elixir setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=4 tabstop=4 softtabstop=4
