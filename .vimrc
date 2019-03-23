" I still have a few things managed throught pathogen
call pathogen#infect()
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
    " Make sure you use single quotes
    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        Plug 'zchee/deoplete-go', { 'do': 'make'}
        Plug 'jodosha/vim-godebug'
        Plug 'hashivim/vim-terraform'
        Plug 'juliosueiras/vim-terraform-completion'
        let g:deoplete#omni_patterns = {}
        let g:deoplete#omni_patterns.terraform = '[^ *\t"{=$]\w*'
        let g:deoplete#enable_at_startup = 1
    endif

    " Plug 'jiangmiao/auto-pairs'
    "Plug 'vim-syntastic/syntastic'
    " Plug 'MattesGroeger/vim-bookmarks'
    " Plug 'StanAngeloff/php.vim'
    Plug 'Yggdroot/indentLine'
    Plug 'chase/vim-ansible-yaml'
    Plug 'crusoexia/vim-monokai'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'elzr/vim-json'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'majutsushi/tagbar'
    Plug 'scrooloose/nerdtree'
    Plug 'stephpy/vim-php-cs-fixer'
    Plug 'tell-k/vim-autopep8'
    Plug 'tpope/vim-commentary' 
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rails'
    Plug 'tpope/vim-rhubarb'
    Plug 'vim-airline/vim-airline'
" Initialize plugin system
call plug#end()



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
set nu                          " show line numbers

nnoremap <F10> :registers<cr>
nnoremap <F11> :buffers<CR>:buffer<Space>
" The following lets :W acts like :w and :Q like :q
cnoreabbrev W w
cnoreabbrev Q q

" appearance
set termguicolors
syntax enable
set background=dark
colorscheme ir_black
" colorscheme monokai

if has('gui_running')
    set background=light
    colorscheme solarized
    set guifont=Monaco:h12
    set guioptions-=T
else
    set background=dark
endif
if &diff
    colorscheme diff_override
endif       

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
"set viminfo='10,\"100,:20,%,n~/.viminfo

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

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


"Set this to 1 to set searching by filename (not full path) as the default:
let g:ctrlp_by_filename = 0

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
"command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" pane navigation
set splitbelow
set splitright
" ********************************
" LANGUAGE SPECIFIC SETTINGS
" ********************************

" interactive shell syntax highlighting 
au BufRead,BufNewFile  bash-fc-* setfiletype sh

" Makefiles must use tabs
au FileType make  set noexpandtab

" ruby does it differenly, so we set local values based on filetype
au Filetype ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2

" SHOP likes shell to look like ruby
au Filetype sh setlocal tabstop=2 softtabstop=2 shiftwidth=2

" so does html. We set indentation to 2 spaces
au Filetype html setlocal tabstop=2 softtabstop=2 shiftwidth=2


" golang
let g:go_fmt_command = "goimports"

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
"let g:go_auto_type_info = 1

au FileType go nmap <leader>gb :GoBuild<cr>
au FileType go nmap <leader>gc :GoCoverageToggle -short<cr>
au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
au FileType go nmap <leader>gt :GoTest -short<cr>
autocmd FileType go nmap <Leader>i <Plug>(go-info)<Paste>
let g:syntastic_go_checkers = ['go', 'golint', 'govet']

" jenkins!
au BufNewFile,BufRead Jenkinsfile setf groovy

" ********************************
" PLUGINS SETTINGS
" ********************************

" closetag.vim settings (for html and xml)
au Filetype html,xml,xsl source ~/.vim/scripts/closetag.vim 

" perltidy
nmap <leader>ry :%!perltidy -q<cr>

" vim-ansible settings (used for yaml)
autocmd BufNewFile,BufRead *yaml  set ft=ansible
au Filetype ansible setlocal tabstop=2 softtabstop=2 shiftwidth=2

" vim-json 
" Disable syntax concealing (hides quotes)
let g:vim_json_syntax_conceal = 0

" nerdtree (Control n)
map <C-n> :NERDTreeToggle<CR>

" vim-terraform
let g:terraform_align=1

" ALE
let g:ale_set_highlights = 0

" terraform completion
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" (Optional)Remove Info(Preview) window
set completeopt-=preview

" (Optional)Hide Info(Preview) window after completions
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" (Optional) Enable terraform plan to be include in filter
let g:syntastic_terraform_tffilter_plan = 1

" (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
let g:terraform_completion_keys = 1

" (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
let g:terraform_registry_module_completion = 0

" PHP fixer 
" If you use php-cs-fixer version 2.x
let g:php_cs_fixer_rules = "@PSR2"                  " options: --rules (default:@PSR2)
"let g:php_cs_fixer_cache = ".php_cs.cache"         " options: --cache-file
"let g:php_cs_fixer_config_file = '.php_cs'         " options: --config
" End of php-cs-fixer version 2 config params

let g:php_cs_fixer_php_path = "php"               " Path to PHP
let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.
