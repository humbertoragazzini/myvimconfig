"////////// NOTES ///////////
"PYTHON
"Some of the plugins relay on python install python3 for vim apt install vim-nox


"/////// GRAL SETTINGS //////
set number
set relativenumber


"////////// STARTUP COMMANDS /////////////
" Start NERDTree automatically when Vim starts, but only if no files are specified in addition we open a terminal and resize it
autocmd VimEnter * if argc() == 0 | execute ' terminal' | resize 10 | startinsert | wincmd k | NERDTree | endif


"///// KEY MAPPING /////////
"Resize keybinding
nnoremap <C-Up>    :resize +1<CR>              " Increase height
nnoremap <C-Down>  :resize -1<CR>              " Decrease height
nnoremap <C-Right> :vertical resize +1<CR>     " Increase width
nnoremap <C-Left>  :vertical resize -1<CR>     " Decrease width

"change window
nnoremap <C-w>w <C-w>w
nnoremap <C-w>W <C-w>W

"Tab to autocomplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"This move the cursor on insert mode
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <Down>
inoremap <C-k> <Up>

"These combination is for saving the files in insert and normal mode
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a

"///////// PLUGIN VARS /////////
" Example: Adjusting vimade fade level
let g:vimade = { 'fadelevel': 0.1 }


"///////// PLUGINS /////////
call plug#begin('~/.vim/plugged')
"Nerdtree
Plug 'preservim/nerdtree'
" HTML, CSS, Tailwind, JS, JSX, and TypeScript Plugins
Plug 'mattn/emmet-vim'                          " Emmet for HTML/CSS
Plug 'ap/vim-css-color'                         " CSS color preview
Plug 'roobert/tailwindcss-colorizer-cmp.nvim'   " TailwindCSS autocompletion
Plug 'sheerun/vim-polyglot'                     " Language syntax highlighting
Plug 'leafgarland/typescript-vim'               " TypeScript support
Plug 'maxmellon/vim-jsx-pretty'                 " JSX/TSX syntax highlighting
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion and linting
Plug 'prettier/vim-prettier', { 'do': 'yarn install' } " Prettier for code formatting
Plug 'neoclide/coc.nvim', {'branch':'release'}
Plug 'TaDaa/vimade'
Plug 'airblade/vim-tailwind'
Plug 'terryma/vim-multiple-cursors'
call plug#end()


"//////////// FUNCTIONS ////////////
"************* for tailwind html jsz tsx and js *****************
"Adding function to autocomplete of tailwind
" Function to detect if Tailwind config file exists
function! s:is_tailwind()
  return !empty(findfile('tailwind.config.js', '.;')) ||
        \ !empty(findfile('config/tailwind.config.js', '.;'))
endfunction

" Autocommand to set Tailwind autocompletion for HTML, Slim, TSX, JSX, and JS files
autocmd BufEnter *.html,*.slim,*.tsx,*.jsx,*.js if s:is_tailwind() |
      \   setlocal omnifunc=tailwind#Complete |
      \ endif

" Enable Emmet for all file types
let g:user_emmet_install_global = 1
autocmd FileType html,css EmmetInstall

" Setup coc.nvim for JavaScript, TypeScript, HTML, CSS, Tailwind CSS
let g:coc_global_extensions = ['coc-tsserver', 'coc-html', 'coc-css', 'coc-tailwindcss']


"//////////////// FORMATING THE FILES ///////////////
" Automatically format code on save
autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx,*.html,*.css Prettier

"////////////// COLORS ///////////////
" Fix popup menu background and text colors
highlight Pmenu guibg=#1e1e2e guifg=#cdd6f4
highlight PmenuSel guibg=#81a1c1 guifg=#1e1e2e
highlight PmenuSbar guibg=#2e3440
highlight PmenuThumb guibg=#81a1c1

" Fix Coc.nvim highlighting for suggestions
highlight CocMenuSel guibg=#81a1c1 guifg=#1e1e2e
highlight CocFloating guibg=#1e1e2e guifg=#cdd6f4
highlight CocErrorSign guibg=#1e1e2e guifg=#bf616a
highlight CocWarningSign guibg=#1e1e2e guifg=#ebcb8b
highlight CocHintSign guibg=#1e1e2e guifg=#a3be8c
highlight CocInfoSign guibg=#1e1e2e guifg=#88c0ff
highlight CocHighlightText guibg=#3b4252 guifg=#cdd6f4

" General UI tweaks for better readability
highlight Normal guibg=#1e1e2e guifg=#cdd6f4
highlight LineNr guifg=#4c566a
highlight CursorLineNr guifg=#81a1c1

"/////////////// CTAGS (TO JUMP TO DEFINITIONS)//////////////
"set the ctag file relative to the project open
set tags=./tags;
