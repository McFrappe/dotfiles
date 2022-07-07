call plug#begin('~/.config/nvim/plugged')
" syntax handling
Plug 'tpope/vim-commentary'
Plug 'anyakichi/vim-surround'
Plug 'folke/zen-mode.nvim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'beyondmarc/hlsl.vim'

" Misc
Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'chrisbra/colorizer'

" Themes
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'
" Plug 'L-TChen/auto-dark-mode.vim'

" Extentions
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lervag/vimtex'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'takac/vim-hardtime'
Plug 'sheerun/vim-polyglot'

call plug#end()

let g:airline_theme='gruvbox'
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

filetype plugin on " Auto-detect un-labeled filetypes
set number relativenumber " Show relative line numbers on the left. These change based upon where your cursor is.
syntax on " Turn syntax highlighting on
set ai " Sets auto-indentation
set noswapfile " Prevent vim from creating .swp files
set cursorline " Highlight current cursor line
set cursorcolumn " Highlight current cursor column
set hlsearch " When searching (/), highlights matches as you go
set incsearch " When searching (/), display results as you type (instead of only upon ENTER)
set ttyfast " Boost speed by altering character redraw rates to your terminal
set showmatch " Show matching brackets when text indicator is over them
set numberwidth=3 " Sets width of the 'gutter' column used for numbering to 3 (default 4)
set clipboard=unnamedplus " Use the OS clipboard by default
set spell

let mapleader=","

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Use D to show documentation in preview window.
nnoremap <silent> <leader>d :call <SID>show_documentation()<CR>

" fzf
nnoremap <silent> <leader>o :Files<CR>
let g:fzf_action = { 'enter': 'tab split' }
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.75, 'relative': v:true } }
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
"
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

" COC settings
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
