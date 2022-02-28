call plug#begin('~/.config/nvim/plugged')
" Position and commenting
Plug 'tpope/vim-commentary'
Plug 'anyakichi/vim-surround' 
Plug 'folke/zen-mode.nvim'

" Misc
Plug 'itchyny/lightline.vim'
Plug 'chrisbra/colorizer'

" Themes
Plug 'nanotech/jellybeans.vim'
Plug 'haystackandroid/snow'
Plug 'Luxed/ayu-vim'
Plug 'severij/vadelma'
Plug 'Rigellute/shades-of-purple.vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'tribela/vim-transparent'

" Extentions
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lervag/vimtex'
Plug 'OmniSharp/omnisharp-vim'
Plug 'inside/vim-search-pulse'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'zivyangll/git-blame.vim'
Plug 'takac/vim-hardtime'
Plug 'bignimbus/you-are-here.vim'

" Syntax
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'darfink/vim-plist'
call plug#end()

" Theming
function! SetBackgroundMode(...)
    let g:new_bg = "light"
    let s:mode = systemlist("defaults read -g AppleInterfaceStyle")[0]

    if s:mode ==? "Dark"
        let g:new_bg = "dark"
        colorscheme onehalfdark " Set your theme here
    endif

    if &background !=? g:new_bg
        let &background = g:new_bg
        colorscheme onehalflight " Set your theme here
    endif

    hi Normal guibg=NONE ctermbg=NONE
endfunction
syntax enable
call SetBackgroundMode()
call timer_start(10000,"SetBackgroundMode", {"repeat": -1})

" vim hardtime
let g:hardtime_default_on = 1
let g:list_of_normal_keys = ["h", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_visual_keys = ["-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]

let mapleader=","

set noerrorbells
filetype plugin on
filetype plugin indent on
autocmd FileType org setlocal foldmethod=syntax

" auto + smart indent for code
set autoindent
set smartindent

" Mouse support (why not right? sometimes im lazy)
set mouse=a

" Disable file backups
set nobackup
set nowritebackup

" no delays!
set updatetime=300

set cmdheight=1
set shortmess+=c

set signcolumn=yes

" Prevent from showing what mode is active (because lightline is active)
" if get(g:, 'loaded_lightline', 0)
"     echomsg "Loaded lightline, disabling 'showmode'"
"     set noshowmode
" else
"     echomsg "Lightline not loaded, turning on 'showmode'"
"     set showmode
" endif
set noshowmode

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

set hidden
set undofile
set incsearch
set tabstop=4
set nowrap
set noswapfile
set shiftwidth=4
set expandtab
set encoding=utf-8
set number
set go=a
set nohlsearch
set clipboard=unnamedplus
set termguicolors

" Settings for viewing the active window
set colorcolumn=80
" Specific length for different filetypes
" autocmd FileType javascript setlocal colorcolumn=120
" autocmd FileType typescript setlocal colorcolumn=120

" Logic for entering/leaving a pane
function! OnWinEnter()
    if exists('w:initial_cc')
        let &colorcolumn = w:initial_cc
    endif
endfunction
function! OnWinLeave()
    if !exists('w:initial_cc')
        let w:initial_cc=&colorcolumn
    endif
    let &colorcolumn = 0
endfunction

augroup BgHighlight
    autocmd!
    autocmd WinEnter * call OnWinEnter()
    autocmd WinLeave * call OnWinLeave()
augroup END

" Enable autocompletion:
set wildmode=longest,list,full

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Lightline configuration
let g:SuperTabCrMapping = 1
set laststatus=2
let g:shades_of_purple_lightline = 1
let g:lightline = {
            \ 'colorscheme': 'onehalfdark',
            \ 'ctive': { 
                \ 'left': [ [ 'mode', 'paste'], 
                \ [ 'readonly', 'relativepath', 'tagbar', 'modified']
                \ ],
                \ },
                \ }

function! LightlineFilename()
    return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
                \ &filetype ==# 'unite' ? unite#get_status_string() :
                \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
                \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction

if !has('gui_running')
    set t_Co=256
endif
" MISC ##########################################################
set t_Co=256

" Replace all occurences of word under cursor
nnoremap <leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

let g:coc_snippet_next = '<S-Tab>'

" Esc when in terminal mode
tnoremap <Esc> <C-\><C-n>:q!<CR>

" C.O.C 
" Tab Completion
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion. COC
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use D to show documentation in preview window.
nnoremap <silent> <leader>d :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Wrapping around the column 80
autocmd FileType tex setlocal formatoptions+=l tw=80
autocmd FileType markdown setlocal formatoptions+=l tw=80
autocmd FileType text setlocal formatoptions+=l tw=80

" fzf
nnoremap <silent> <leader>o :GFiles<CR>

" Open in new tab by default
let g:fzf_action = { 'enter': 'tab split' }
let g:fzf_layout = { 'down': '40%' }

let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Vimtex settings
let g:tex_flavor = 'latex'
let g:vimtex_view_method = "skim"
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
let g:vimtex_compiler_latexmk = {
            \ 'options' : [
                \   '-pdf',
                \   '-shell-escape',
                \   '-verbose',
                \   '-file-line-error',
                \   '-synctex=1',
                \   '-interaction=nonstopmode',
                \ ],
                \}

augroup vimtex_mac
    autocmd!
    autocmd User VimtexEventCompileSuccess call UpdateSkim()
augroup END

" Function to use along Skim PDF application
function! UpdateSkim() abort
    let l:out = b:vimtex.out()
    let l:src_file_path = expand('%:p')
    let l:cmd = [g:vimtex_view_general_viewer, '-r']

    if !empty(system('pgrep Skim'))
        call extend(l:cmd, ['-g'])
    endif

    call jobstart(l:cmd + [line('.'), l:out, l:src_file_path])
endfunction

" OmniSharp conf (c#)
nnoremap <C-o><C-d> :OmniSharpGotoDefinition<CR>
nnoremap <C-o><C-d><C-p> :OmniSharpPreviewDefinition<CR>
nnoremap <C-o><C-r> :!dotnet run

" You are here config
" nnoremap <silent> <leader>here :call you_are_here#Toggle()<CR>
" nnoremap <silent> <leader>here :call you_are_here#ToggleFor(2500)<CR>

