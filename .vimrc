" Stephen Hara (github.com/tarsir) dot vimrc
" Most recent changes: May 27, 2016
" Some basic helpful factoids about this .vimrc:
"   - uses Vundle
"   - primarily for Python development
"   - also makes use of some Angular and Javascript fun stuff

" Some basic stuff up front
set backspace=2
set nocompatible              " be iMproved, required
filetype off                  " required

" Custom pymode options
let g:pymode_options_max_line_length = 99
let g:pymode_lint_ignore = "R0201"

" Change leader because reasons
let mapleader = ","

" custom remappings
" quickly reload vimrc
map <Leader>f :source ~/.vimrc<CR>
" Ctrl-S to save
map <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>

"python toggle IPython embed
" and other niceties for Python
map <leader>ip :call ToggleIPython()<CR>
map <leader>pr :!python %<CR>
" map <leader>pv :Pytest file -s<CR>
" map <leader>pt :Pytest file<CR>
map <leader>pdv :! $AVER_SOURCE/rouster/rind exec api py.test /aver/%<CR>

" Ctrl-y to reload all windows in all tabs
map <C-y> :tabdo exec 'windo e'<CR>

" fugitive leader mappings
map <leader>gd :Gdiff<cr>
map <leader>gs :Gstatus<cr>
map <leader>gc :Gcommit -v<cr>
map <leader>gcv :Gcommit --no-verify -v<cr>
map <leader>gt :Gcommit -v -q %:p<cr>
map <leader>go :Git checkout -- %:p
map <leader>gl :Git log -n 5<cr>
map <leader>gw :Gwrite<cr>
map <Leader>gg :Ggrep<space>
map <leader>gp :Git push<cr>
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>grm :Git rm %:p<CR><CR>

" easy movement
map <C-j> <C-w>j
map <C-h> <C-w>h
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-a> :tabprevious<CR>
map <C-d> :tabnext<CR>
map <leader>tp :tabc<CR>
nnoremap <Leader>zz :let &scrolloff=15-&scrolloff<CR>

" buffergator so it doesn't interfere with pymode
map <leader>bg :BuffergatorToggle<cr>
map <Leader>lt :call ToggleBackground()<CR>
map <leader>li :call ITermConfig()<CR>

" run Jasmine tests in current buffer
map <leader>m :JasmineRedGreen<cr>

" TagbarToggle
map <C-t> :TagbarToggle<cr>

" Vundle list
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

"Python Plugins
" Plugin 'scrooloose/nerdcommenter'
Plugin 'klen/python-mode'
Plugin 'alfredodeza/pytest.vim'

" JavaScript/Node/Angular
" Plugin 'moll/vim-node'
" Plugin 'marijnh/tern_for_vim'
Plugin 'walm/jshint.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'guileen/vim-node-dict'
Plugin 'othree/javascript-libraries-syntax.vim' 
Plugin 'claco/jasmine.vim' 
Plugin 'matthewsimo/angular-vim-snippets'

" SQL what up
Plugin 'vim-scripts/dbext.vim'
Plugin 'krisajenkins/vim-pipe'
Plugin 'krisajenkins/vim-postgresql-syntax'

" General vim plugins
Plugin 'godlygeek/tabular'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'groenewege/vim-less'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'majutsushi/tagbar'
Plugin 'StanAngeloff/php.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'altercation/vim-colors-solarized'
Plugin 'BufOnly.vim'
Plugin 'rking/ag.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()       
syntax enable
filetype plugin indent on
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Python tab width = 4 + tab into spaces
set ts=4
set expandtab
autocmd BufWritePre *.py :%s/\s\+$//e

" UltiSnips config
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<cr>"
let g:UltiSnipsJumpForwardTrigger="<cr>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:ycm_path_to_python_interpreter = '/usr/bin/python'

" silent! iunmap <CR>
imap <S-Enter> <C-R>=UltiSnips#ExpandSnippetOrJump()<CR> 
silent! iunmap <CR>


" Javascript lib syntax for completions
autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1
autocmd BufReadPre *.js let b:javascript_lib_use_underscore = 1
autocmd BufReadPre *.js let b:javascript_lib_use_backbone = 1
autocmd BufReadPre *.js let b:javascript_lib_use_angularjs = 1
autocmd BufReadPre *.js let b:javascript_lib_use_coffee = 1

"Solarized config
set background=dark
colorscheme solarized

"NerdTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '__pycache__']

" Status line

"set statusline=%{fugitive#statusline()} "fugitive status
"set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
"set statusline+=%{&ff}] "file format
"set statusline+=%m  "modified flag
"set statusline+=%y  "filetype
"set statusline+=%=  "left/right separator
"set statusline+=%c,  "cursor column
"set statusline+=%l/%L  "cursor line/total lines
"set statusline+=\ %P   "percent through file

" Airline config
set laststatus=2
let g:airline_theme = 'wombat'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#format = 0
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
        let g:airline_symbols = {}
endif

" Pymode
let g:pymode_lint_on_write = 1 " Code check on every modify save
let g:pymode_rope = 0 " disable rope because FTS
let g:pymode_rope_rename_bind = '<C-c>rr'
let g:pymode_rope_lookup_project = 0 " This at non-0 makes things unbearably slow
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>pb'

" Change some warnings
let g:pymode_lint_ignore = "superfluous-parens"

"" Ctrl-P settings
" set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/bower_components/*,*/node_modules/*,*.pyc
let g:ctrlp_custom_ignore = {
    \   'dir': '\v[\/]((\.(git|hg|svn))|(bower_components|node_modules))$',
    \   'file': '\v\.(pyc)$',
    \ }

" custom macros

" goes to the end of the current word and inserts at all instances of that
" word a "data_model." prefix to be verbose about imports from Core.data_model
let @a='vey:1,$s/\("\)/data_model.\1/gc'

" does an Ag search on the word under cursor
let @s='yiw:Ag'

" and then bind this to ',ar'
map <leader>ar @a
" no line wrap
set nowrap
" numbers on left
set number

" Custom functions
" python insert/remove IPython embed call
function! ToggleIPython()
    let line=getline('.')
    if line =~ "import IPython"
        execute "normal! dd"
    else
        execute "normal! O"
        call setline('.', "import IPython; IPython.embed()")
        execute "normal! =="
    endif
endfunction

" toggle background
function! ToggleBackground()
    if &background =~ 'dark'
            set background=light
    else
            set background=dark
    endif
endfunction

" solarized config for iterm
function! ITermConfig()
        let g:solarized_termtrans = 1
        let g:solarized_visibility = "high"
        let g:solarized_contrast = "high"
        let g:solarized_termcolors = 16
        colorscheme solarized
endfunction

" Filetype specific tabs and such
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4
autocmd FileType css setlocal shiftwidth=4 tabstop=4
autocmd FileType php setlocal shiftwidth=4 tabstop=4
autocmd FileType cpp setlocal shiftwidth=4 tabstop=4
autocmd FileType sh setlocal shiftwidth=4 tabstop=4
autocmd FileType sql let b:vimpipe_command="d.bash postgres psql mydb myuser"
" JSON formatting and such
au BufRead,BufNewFile *.aver setfiletype json
au Bufread,BufNewFile *.html setlocal textwidth=80
nnoremap <leader>js :%!python -m json.tool<CR>

" vim-javascript options
let b:javascript_fold=1

" misc settings
set sj=-30
