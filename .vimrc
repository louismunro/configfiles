call pathogen#infect()
set nocompatible
filetype plugin indent on
set visualbell
set modelines=0                 " prevent exploits based on modelines
set showcmd                     " show details on bottom line
set ruler                       " show postion on bottom line
set wrap                        " wrap visually but do not change text
set backspace=indent,eol,start  " backspace all the way to previous line 
set wildmenu                    " show possible matches when completing commands
set wildmode=list:longest       " options to wildmenu
set cursorline                  " highlight current line
set ttyfast                     " optimisation for ttys
set laststatus=2                " show a status if there are mor than one file
set scrolloff=3                 " keep at least three line visible before/after cursor
set matchpairs+=<:>             " Allow % to bounce between angles too
set pastetoggle=<F12>           " toggle paste mode with F12

nnoremap <F10> :registers<cr>
nnoremap <F11> :buffers<CR>:buffer<Space>
" The following lets :W acts like :w and :Q like :q
cnoreabbrev W w
cnoreabbrev Q q

" appearance
syntax enable
set background=dark
colorscheme ir_black
if &diff
    colorscheme ir_black_override
endif       
set guifont=Monaco:h12
set guioptions-=T

" search settings
" the first two lines change the regex to PCRE. Caution: do not add ANYTHING 
" after \v (not even whitespace)
nnoremap / /\v
vnoremap / /\v
set incsearch                   " incremental search
set showmatch                   " showmatches as you type
set hlsearch                    " highlight matches 
set ignorecase                  " search is case insensitive by default
set smartcase                   " unless you type a mix of upper and lower case
highlight Search ctermfg=yellow cterm=underline ctermbg=black " make search results readable

" clear out a search with <leader><space>
nnoremap <leader><space> :noh<cr>

" indentation settings: only insert spaces
set autoindent
set tabstop=4                   " show actual tabs as 4 spaces
set smarttab                    " outdent when pressing backspace
set expandtab                   " insert spaces instead of tabs
set softtabstop=4               " how many columns vim uses when you hit Tab in insert mode
set shiftwidth=4                " how many columns text is indented
" make tab in v mode ident code
vmap <tab> >gv
vmap <s-tab> <gv
 
" make tab in normal mode ident code
nmap <tab> I<tab><esc>
nmap <s-tab> ^i<bs><esc>

" add git hook generated tags to ctags path
set tags+=.git/tags

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" remap jj as esc key
ino jj <esc>
cno jj <c-c>

" ********************************
" LANGUAGE SPECIFIC SETTINGS
" ********************************

" interactive shell syntax highlighting 
au BufRead,BufNewFile  bash-fc-* setfiletype sh

" Makefiles must use tabs
au FileType make  set noexpandtab

" ruby does it differenly, so we set local values based on filetype
au Filetype ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2

" so does html. We set indentation to 2 spaces
au Filetype html setlocal tabstop=2 softtabstop=2 shiftwidth=2


" golang
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_trailing_whitespace_error = 0

" ********************************
" PLUGINS SETTINGS
" ********************************

" closetag.vim settings (for html and xml)
au Filetype html,xml,xsl source ~/.vim/scripts/closetag.vim 

" perltidy
nmap <leader>ry :%!perltidy -q<cr>

" vim-ansible settings (used for yaml)
autocmd BufNewFile,BufRead *.yaml  set ft=ansible

" vim-json 
" Disable syntax concealing (hides quotes)
let g:vim_json_syntax_conceal = 0

" nerdtree (Control n)
map <C-n> :NERDTreeToggle<CR>
