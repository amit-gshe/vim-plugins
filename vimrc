execute pathogen#infect()

" GUI options
if has("gui_running")
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
    set guifont=Monospace\ 12
endif

set nu
set ruler
set showcmd 

" Converting tabs to spaces
set expandtab

set smartindent
set shiftwidth=4
set smarttab

set mouse=a

syntax on
filetype plugin indent on
set fileencodings=utf8,gbk,gb2312,gb18030

" Load a buffer in a window that currently has a modified buffer

"set hlsearch
"set ignorecase
set autoread
set scrolloff=3

" Replace the title bar with the file path editing now
set title
"set titlestring=\ %-25.55F\ %a%r%m titlelen=70

" Keyboard remap (insert->inoremap normal->nnoremap visual->vnoremap)
 inoremap <unique> <c-h> <left>
 inoremap <unique> <c-j> <down>
 inoremap <unique> <c-k> <up>
 inoremap <unique> <c-l> <right>
 inoremap <silent> <C-S> <C-O>:update<CR>
 
 "ctrl-s to save 
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Auto-save a file when you leave insert mode
"autocmd InsertLeave * if expand('%') != '' |update|endif

" Auto open the nurdtree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <F12> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" javascript-libraries-syntax
let g:used_javascript_libs = 'jquery,angularjs'

" Use emmet plugin only in html and css file
let g:user_emmet_install_global = 0
autocmd FileType html,htm,xhtml,css,scss,jsp,php,asp,xml EmmetInstall
" Press the ctrl+z to trigger the emmet plugin
let g:user_emmet_leader_key = '<C-Z>'

set omnifunc=syntaxcomplete#Complete
" Note: This option must set it in .vimrc (_vimrc).
" NOT IN .gvimrc (_gvimrc)!
" Disable AutoComplPop.
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior (not recommended.)
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" :
" \ neocomplete#start_manual_complete()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php =
"\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
"let g:neocomplete#sources#omni#input_patterns.c =
"\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
"let g:neocomplete#sources#omni#input_patterns.cpp =
"\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl =
            \ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

" For smart TAB completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
"        \ <SID>check_back_space() ? "\<TAB>" :
"        \ neocomplete#start_manual_complete()
"  function! s:check_back_space() "{{{
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1]  =~ '\s'
"  endfunction"}}}

" Compile the code based on file types
map <F5> :call Compile()<CR>
function Compile()
    silent exec "w"
    silent exec "!clear"
    if &filetype == 'c' 
        exec "!gcc % -o %<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
    elseif &filetype == 'java'
        exec "!javac %"
    else 
        exec "echo 'Nothing to compile\!'"
    endif
endfunc 

" Run the compiled excutable file
map <F6> :call Run()<CR>
function Run()
    silent exec "w"
    silent exec "!clear"
    if &filetype ==  'c'|| &filetype=='cpp' 
        exec "! ./%<"
    elseif &filetype == 'java'
        exec '!java %<'
    elseif &filetype == 'python'
        exec '!python %'
    else 
        exec "echo 'Nothing to run\!'"
    endif
endfunc

" Create the path to a new file if directory to the new file not exists
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

