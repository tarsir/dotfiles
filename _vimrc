" Detect OS
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
        let g:home = "$HOME"
        let s:config_file_prefix = "_"
        cd F:\Development
    else
        let g:os = substitute(system('uname'), '\n', '', '')
        let g:home = "~""
        let s:config_file_prefix = "."
    endif
endif

" Check if we're in nvim
if !exists("s:editor_root")
	if has('nvim')
		let s:editor_root=expand(g:home . "/.config/nvim")
        let s:config_file=expand(g:home . "/AppData/Local/nvim/init.vim")
	else
		let s:editor_root=expand(g:home . "/.vim")
        let s:config_file=expand("C:/Programming/Editors/Vim" . "/" . s:config_file_prefix . "vimrc")
	end
endif

" are we gui?
if has('gui_running')
  set guifont=Source\ Code\ Pro:h14
endif

function! EditConfigFile()
    execute "tabe " . s:config_file
endfunction

function! LoadConfigFile()
    execute "source " . s:config_file
endfunction


" Some basic stuff up front
set backspace=2
set tabstop=4
set softtabstop=4
set shiftwidth=4
set nocompatible              " be iMproved, required
filetype off                  " required

" Custom pymode options
" let g:pymode_options_max_line_length = 99
" let g:pymode_lint_ignore = "R0201"

" Change leader because reasons
let mapleader = ","

" custom remappings
" quickly reload vimrc
map <Leader>f :call LoadConfigFile()<CR>
map <Leader>ce :call EditConfigFile()<CR>
" Ctrl-S to save
map <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>

"python toggle IPython embed
" and other niceties for Python
" map <leader>ip :call ToggleIPython()<CR>
" map <leader>pr :!python %<CR>
" map <leader>pv :Pytest file -s<CR>
" map <leader>pt :Pytest file<CR>

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

" set the runtime path to include Vundle and initialize
let &rtp = &rtp . ',' . s:editor_root . '\bundle\Vundle.vim'
let bundle_loc = s:editor_root . '\bundle'

call vundle#rc(bundle_loc)
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" General vim plugins
" Plugin 'Valloric/YouCompleteMe'
Plugin 'lifepillar/vim-mucomplete'
Plugin 'ervandew/supertab'
Plugin 'SirVer/ultisnips'
Plugin 'godlygeek/tabular'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'BufOnly.vim'
Plugin 'rking/ag.vim'
Plugin 'honza/vim-snippets'
Plugin 'editorconfig/editorconfig-vim'

" Git 'r done
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Color schemes and aesthetics
Plugin 'lifepillar/vim-solarized8'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" JavaScript/Node/Angular/CSS
Plugin 'moll/vim-node'
Plugin 'guileen/vim-node-dict'
Plugin 'marijnh/tern_for_vim'
Plugin 'claco/jasmine.vim'
Plugin 'posva/vim-vue'
Plugin 'jiangmiao/auto-pairs'
Plugin 'jason0x43/vim-js-indent'
Plugin 'Quramy/vim-js-pretty-template'
Plugin 'Quramy/tsuquyomi'
Plugin 'leafgarland/typescript-vim'
Plugin 'walm/jshint.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'groenewege/vim-less'

" SQL what up
" Plugin 'vim-scripts/dbext.vim'
" Plugin 'krisajenkins/vim-pipe'
" Plugin 'krisajenkins/vim-postgresql-syntax'

" Elixir
Plugin 'elixir-lang/vim-elixir'
Plugin 'mattonrails/vim-mix'
Plugin 'slashmili/alchemist.vim'

" Rust
" Plugin 'rust-lang/rust.vim'

"Python Plugins
Plugin 'klen/python-mode'
Plugin 'alfredodeza/pytest.vim'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on    " required
syntax on

" autocomplete stuff

set omnifunc=syntaxcomplete#Complete
set noshowmode shortmess+=c
set completeopt+=menuone,noinsert,noselect
inoremap <expr> <c-e> mucomplete#popup_exit("\<c-e>")
inoremap <expr> <c-y> mucomplete#popup_exit("\<c-y>")
inoremap <expr>  <cr> mucomplete#popup_exit("\<cr>")
let g:mucomplete#enable_auto_at_startup = 1

" To ignore plugin indent changes, instead use:
"filetype plugin on

let g:UltiSnipsExpandTrigger="<c-i>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" " If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:ycm_path_to_python_interpreter = '/usr/bin/python'

" silent! iunmap <CR>
silent! iunmap <CR>
imap <S-Enter> <C-R>=UltiSnips#ExpandSnippetOrJump()<CR>


" Javascript lib syntax for completions
autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1
autocmd BufReadPre *.js let b:javascript_lib_use_underscore = 1
autocmd BufReadPre *.js let b:javascript_lib_use_backbone = 1
autocmd BufReadPre *.js let b:javascript_lib_use_angularjs = 1
autocmd BufReadPre *.js let b:javascript_lib_use_coffee = 1

"Solarized config
" set background=dark
" colorscheme solarized

" Colorscheme (gruvbox) config
set background=dark

"NerdTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '__pycache__', '\.o$', 'node_modules', 'swp$', 'smartcare/$', '.cache']

" Airline config
set laststatus=2
let g:airline_theme = 'wombat'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#format = 0
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
        let g:airline_symbols = {}
endif

" Gitgutter
let g:gitgutter_eager = 0

" " Pymode
let g:pymode_lint_on_write = 0 " Code check on every modify save
let g:pymode_rope = 0 " disable rope because FTS
" let g:pymode_rope_rename_bind = '<C-c>rr'
" let g:pymode_rope_lookup_project = 0 " This at non-0 makes things unbearably slow
" let g:pymode_breakpoint = 1
" let g:pymode_breakpoint_bind = '<leader>pb'

" " Change some warnings
" let g:pymode_lint_ignore = "superfluous-parens"

"" Ctrl-P settings
" set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/bower_components/*,*/node_modules/*,*.pyc
let g:ctrlp_custom_ignore = {
    \   'dir': '\v[\/]((\.(git|hg|svn))|(bower_components|node_modules|vendor|_build))$',
    \   'file': '\v\.((pyc)|(min\.js)|(jpg|png|gif|bmp))$',
    \ }

" custom macros
" jk none right now

" no line wrap
set nowrap
" numbers on left
set number

" Custom functions
" python insert/remove IPython embed call
" function! ToggleIPython()
"     let line=getline('.')
"     if line =~ "import IPython"
"         execute "normal! dd"
"     else
"         execute "normal! O"
"         call setline('.', "import IPython; IPython.embed()")
"         execute "normal! =="
"     endif
" endfunction

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
        colo solarized8
endfunction

" Filetype specific tabs and such
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType css setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType php setlocal shiftwidth=4 tabstop=4 softtabstop=4
" autocmd FileType cpp setlocal shiftwidth=4 tabstop=4
" autocmd FileType sh setlocal shiftwidth=4 tabstop=4
" autocmd FileType pl setlocal shiftwidth=4 tabstop=4
" autocmd FileType sql let b:vimpipe_command="d.bash postgres psql mydb myuser"

" Filetype behavior
au BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.jsx
au BufNewFile,BufRead *.ts set filetype=typescript
au Bufread,BufNewFile *.html setlocal textwidth=80
au Bufread,BufEnter *.php setfiletype php

" Misc
nnoremap <leader>js :%!python -m json.tool<CR>

" vim-javascript options
let b:javascript_fold=1

" misc settings
set sj=-30
set expandtab
call ITermConfig()
