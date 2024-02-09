" I still have a few things managed throught pathogen
call pathogen#infect()
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
    " Make sure you use single quotes
    Plug 'ngmy/vim-rubocop'
    Plug 'Yggdroot/indentLine'
    Plug 'chase/vim-ansible-yaml'
    Plug 'crusoexia/vim-monokai'
    Plug 'ctrlpvim/ctrlp.vim'


    Plug 'vim-airline/vim-airline'
    " Plug 'dense-analysis/ale'
    " Set this. Airline will handle the rest.
    let g:airline#extensions#ale#enabled = 1

    Plug 'elzr/vim-json'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'buoto/gotests-vim'

    Plug 'scrooloose/nerdtree'
    Plug 'tell-k/vim-autopep8'
    Plug 'tpope/vim-commentary' 
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rails'
    Plug 'tpope/vim-rake'
    " Plug 'tpope/vim-rhubarb' " Fancy github support :-)

    if has('nvim')
        Plug 'jodosha/vim-godebug'
        Plug 'hashivim/vim-terraform'
        Plug 'juliosueiras/vim-terraform-completion'

        Plug 'jparise/vim-graphql'

        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        " don't give |ins-completion-menu| messages.
        set shortmess+=c
        " always show signcolumns
        set signcolumn=yes
        set signcolumn=number

        function! CheckBackspace() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction
        " Use tab for trigger completion with characters ahead and navigate.
        " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
        " other plugin before putting this into your config.
        inoremap <silent><expr> <TAB>
              \ coc#pum#visible() ? coc#pum#next(1):
              \ CheckBackspace() ? "\<Tab>" :
              \ coc#refresh()
        inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

        " Make <CR> to accept selected completion item or notify coc.nvim to format
        " <C-g>u breaks current undo, please make your own choice.
        inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


        " Remap for rename current word
        nmap <leader>rn <Plug>(coc-rename)
        " Remap for format selected region
        vmap <leader>f  <Plug>(coc-format-selected)
        nmap <leader>f  <Plug>(coc-format-selected)
        " Remap keys for gotos
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)
        " disable vim-go :GoDef short cut (gd)
        " this is handled by LanguageClient [LC]
        let g:go_def_mapping_enabled = 0
    endif
call plug#end()

set hidden " Required for specific actions that require multiple buffers
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
set cmdheight=2                 " Give more space for displaying messages.

" the next line disables ex mode
nnoremap Q <Nop>
nnoremap <F9>  :IndentLinesToggle<cr>
nnoremap <F10> :registers<cr>
" nnoremap <F11> :buffers<CR>:buffer<Space>
nnoremap <F11> :CtrlPBuffer<CR>
nnoremap <F12> :CtrlP<CR>
" The following lets :W acts like :w and :Q like :q
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa

" toggle between recent files
nnoremap <leader><leader> :b#<CR>
" appearance
set termguicolors
syntax enable
set background=dark
" colorscheme ir_black
colorscheme monokai

if has('gui_running')
    set background=dark
    colorscheme solarized
    "set guifont=Monaco:h12
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

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

let g:ctrlp_cmd = 'CtrlPBuffer'
"Set this to 1 to set searching by filename (not full path) as the default:
let g:ctrlp_by_filename = 0

" bind K to grep word under cursor
" nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
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
au Filetype yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2

" so does html. We set indentation to 2 spaces
au Filetype html setlocal tabstop=2 softtabstop=2 shiftwidth=2

" graphql too 
au Filetype graphql setlocal tabstop=2 softtabstop=2 shiftwidth=2

" golang
"let g:go_version_warning = 0 " remove when upgrading neovim
let g:go_fmt_command = "goimports"

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_auto_type_info = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_command = "golangci-lint"
let g:go_metalinter_command_enabled = ['vet', 'revive', 'errcheck']

let g:LanguageClient_serverCommands = {
    \ 'go': ['gopls']
    \ }

au FileType go nmap <leader>gb :GoBuild<cr>
au FileType go nmap <leader>gc :GoCoverageToggle -short<cr>
au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
au FileType go nmap <leader>gt :GoTest -short<cr>
autocmd FileType go nmap <Leader>i <Plug>(go-info)<Paste>

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
" Prevent indentline from breaking quoting around keys and values
let g:indentLine_concealcursor=""

" nerdtree (Control n)
map <C-n> :NERDTreeToggle<CR>

" vim-terraform
let g:terraform_align=1
"let g:terraform_fmt_on_save=1

" ALE
let g:ale_set_highlights = 0
" disable ale for go since it conflicts with vim-go
let g:ale_linters = { 'ruby': [ 'rubocop' ], 'go': []}
let g:ale_fixers = { 'ruby': [ 'rubocop' ], }
let g:ale_fix_on_save = 0

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


" remap arrow keys 
noremap <Up> <C-W>+
noremap <Down> <C-W>-
noremap <Left> <C-W>>
noremap <Right> <C-W><

inoremap <Up> <C-W>+
inoremap <Down> <C-W>-
inoremap <Left> <C-W>>
inoremap <Right> <C-W><

vnoremap <Up> <C-W>+
vnoremap <Down> <C-W>-
vnoremap <Left> <C-W>>
vnoremap <Right> <C-W><
