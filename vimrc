" This is the configuration file for vi and vim
" This default was created for you
" You can modify it as you wish

scriptencoding utf-8
set encoding=utf-8

" Kaleidescape Indenting Style
set backspace=indent,eol,start   " Allow backspacing over indents, end of lines and start of lines
set tabstop=8                    " Default tabstop is 8
set softtabstop=4                " However we set our soft tab stop (number of spaces in a row that
set expandtab                    " counts as a tab to 4). With expand tab this makes vi behave like
set shiftwidth=4                 " tabstop is 4 when it's not. Shiftwidth is the number of spaces to
set smarttab                     " use for autoindent. smarttab allows us to backspace a 'tab' of 4 
set textwidth=0                  " characters and insert the same at the beginning of a line.
set wrapmargin=0                 " stop wrapping line automatically

" Helpful vim features
set wildmenu                     " Command line completion operatings in enhanced mode
set confirm                      " Confirm save of unsaved documents on quite
set hidden                       " Buffer (file) is hidden when abandoned
set number                       " Puts line numbers on by default 'set nonumber' turns them off
set incsearch                    " Search as the search is typed in i.e. '/abc would find the first
set ruler                        " a, then ab, then abc. Ruler shows status line in vim (not vi)
set laststatus=2                 " always show a status line on the last window
set nowrap                       " Lines do not wrap on screen to next line. (Doesn't affect file)
set ignorecase                   " Ignore case in search paterns
set smartcase                    " If Caps are used in search, then don't ignore case in search 
set smartindent                  " Do smart autoindenting of next line
set autoindent                   " Auto indent next line if current line is indented
set showmatch                    " When a bracket is inserted, briefly jump to matching bracket

" Helpful Settings added by me
set nobackup                     " Don't keep backup littered about

""""""""""""""""""""""""""""""""""""""""""""""""""
" Templates
" These templates have been sym-linked into your
" home directory under .vim/templates/
" If you don't want to use templates or want to modify
" them, simply remove the sym-link and create your own
" or delete the section below to stop templates altogether
:augroup BufNewFileFromTemplate
:au!
:autocmd BufNewFile *.py 0r ~/.vim/templates/py.tpl
:autocmd BufNewFile *.sh 0r ~/.vim/templates/bash.tpl
:autocmd BufNewFile *.pl 0r ~/.vim/templates/perl.tpl
:augroup BufNewFileFromTemplate

" Force syntax highlighting on
syntax on

" Lightly highlight any text over 120 characters and add
" a light grey bar at column position 100
highlight OverLength ctermbg=red ctermfg=white guibg=#FFD9D9
match OverLength /\%120v.\+/
let &colorcolumn="100,".join(range(120,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27

" Pathogen integration for better plugin management
execute pathogen#infect()

let g:Powerline_symbols = 'fancy'

" Tagbar integration
let g:tagbar_type_php  = {
 \ 'ctagstype' : 'php',
 \ 'kinds'     : [
     \ 'i:interfaces',
     \ 'c:classes',
     \ 'd:constant definitions',
     \ 'f:functions',
     \ 'j:javascript functions:1'
 \ ]
\ }

cmap tb TagbarToggle

" tagbar-phpctags.vim integration
let g:tagbar_phpctags_bin='/home/ian.muir/depot/headend/store/main/shared/scripts/ctagger_php'

" Exuberant ctags path
set tags=tags;/

" lightline.vim integration
let g:lightline = {
  \ 'component': {
  \   'readonly': '%{&readonly?"⭤":""}',
  \ },
  \ 'separator': { 'left': "⮀", 'right': "⮂" },
  \ 'subseparator': { 'left': "⮁", 'right': "⮃" },
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'filename' ] ],
  \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
  \ },
  \ 'component_function': {
  \   'filename': 'MyFilename',
  \   'fileformat': 'MyFileformat',
  \   'filetype': 'MyFiletype',
  \   'fileencoding': 'MyFileencoding',
  \   'mode': 'MyMode',
  \ },
  \ 'component_expand': {
  \   'syntastic': 'SyntasticStatuslineFlag',
  \ },
  \ 'component_type': {
  \   'syntastic': 'error',
  \ },
\ }

function! MyModified()
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '*' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
    \ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
    \  &ft == 'unite' ? unite#get_status_string() : 
    \  &ft == 'vimshell' ? vimshell#get_status_string() :
    \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
    \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
    if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
        let _ = fugitive#head()
        return strlen(_) ? '⭠ '._ : ''
    endif
    return ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
    return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" tmuxline integration
let g:tmuxline_separators = {
    \ 'left' : '⮀',
    \ 'left_alt': '⮁',
    \ 'right' : '⮂',
    \ 'right_alt' : '⮃',
    \ 'space' : ' ' }

" promptline integration
let g:promptline_powerline_symbols = 0
let g:promptline_symbols = {
    \ 'left' : '⮀',
    \ 'left_alt': '⮁',
    \ 'dir_sep' : ' / ',
    \ 'truncation' : '...',
    \ 'vcs_branch' : '',
    \ 'space' : ' ' }

let g:promptline_preset = {
    \'a' : [ promptline#slices#host() ],
    \'b' : [ promptline#slices#user() ],
    \'c' : [ '$(virtualenv_desc)', promptline#slices#cwd() ],
    \'warn' : [ promptline#slices#last_exit_code() ] }

if !has('gui_running')
    set t_Co=256
endif

" @param filename the filename to checkout in perforce
" @param a:0 an optional changelist
function Checkout(filename, ...)
    if a:0 == ""
	execute "!p4 edit" a:filename
    else
	execute "!p4 edit -c" a:1 " " a:filename
    endif
    execute "e!"
endfunction

function Revert(filename)
    execute "!p4 revert" a:filename
    execute "e!"
endfunction

" @param filename the filename to add in perforce
" @param a:0 an optional changelist
function Add(filename, ...)
    if a:0 == ""
	execute "!p4 add" a:filename
    else
	execute "!p4 add -c" a:1 " " a:filename
    endif
    execute "e!"
endfunction

function CheckoutPrompt(filename, ...)
    let choice = confirm("File is read only, check out [default CL]?", "&Yes\n&No", 2, "Question")
    if choice == 1
	call Checkout(a:filename, "default")
	syn on "dunno why but this is needed
    endif
endfunction

" When trying to edit a read-only file, ask the user if they want to check the file out.
autocmd FileChangedRO *.html,*.sql,Makefile*,*.make,*.txt,*.php,*.js,*.yaml,*.scss call CheckoutPrompt("%")

" NERD Commenter
filetype plugin on

" if 'readonly' is set, then set 'nomodifiable'
" autocmd BufReadPost * let &l:modifiable = !&readonly

command -nargs=? CO call Checkout("%", <args>)
command -nargs=? ADD call Add("%", <args>)
command -nargs=0 RE call Revert("%")

map <C-n> :NERDTreeToggle<CR>
