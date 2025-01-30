"////////// NOTES ///////////
" PYTHON
" Some of the plugins rely on Python. Install python3 for Vim:
" On Debian/Ubuntu: apt install vim-nox
" On Arch: pacman -S python

"////////// GENERAL SETTINGS ///////////
" Line numbers
set number
set relativenumber

"////////// FOLDING SETTINGS ///////////
" Auto start command for AnyFold function (folds functions and blocks of code)
autocmd FileType * AnyFoldActivate
" AnyFold settings
set foldmethod=syntax  " Use syntax-based folding
set foldlevelstart=7   " Open folds when opening a file
set foldlevel=7        " Ensure folds remain open

"////////// STARTUP COMMANDS ///////////
" Start NERDTree automatically when Vim starts, but only if no files are specified
" Additionally, open a terminal and resize it
autocmd VimEnter * if argc() == 0 | execute 'terminal' | resize 10 | startinsert | wincmd k | NERDTree | endif

"////////// KEY MAPPINGS ///////////
" Resize keybindings
nnoremap <C-Up>    :resize +1<CR>              " Increase height
nnoremap <C-Down>  :resize -1<CR>              " Decrease height
nnoremap <C-Right> :vertical resize +1<CR>     " Increase width
nnoremap <C-Left>  :vertical resize -1<CR>     " Decrease width

" Change window
nnoremap <C-w>w <C-w>w
nnoremap <C-w>W <C-w>W

" Tab to autocomplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Move cursor in insert mode
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <Down>
inoremap <C-k> <Up>

" Save files in insert and normal mode
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a

" Exit the file
nnoremap <C-q> :q<CR>
inoremap <C-q> <Esc>:q<CR>a

" NERDTree toggle show and hide
nnoremap <C-A-n> :NERDTreeToggle<CR>
nnoremap <S-F2> :NERDTreeToggle<CR>

" Enable popup for coc.nvim definitions
nnoremap K :call CocActionAsync('doHover')<CR>

"////////// PLUGIN VARIABLES ///////////
" Adjusting vimade fade level
let g:vimade = { 'fadelevel': 0.9 }

"////////// PLUGINS ///////////
call plug#begin('~/.vim/plugged')

" NERDTree
Plug 'preservim/nerdtree'

" HTML, CSS, Tailwind, JS, JSX, and TypeScript Plugins
Plug 'mattn/emmet-vim'                          " Emmet for HTML/CSS
Plug 'ap/vim-css-color'                         " CSS color preview
Plug 'sheerun/vim-polyglot'                     " Language syntax highlighting
Plug 'leafgarland/typescript-vim'               " TypeScript support
Plug 'maxmellon/vim-jsx-pretty'                 " JSX/TSX syntax highlighting
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion and linting
" Before using popup functions, install the servers for the used languages:
" :CocInstall coc-tsserver
" :CocInstall coc-html coc-css coc-tailwindcss
" :CocInstall coc-pyrighl
" You will need to install the tailwindcss server and configure the CocConfig
" file on vim running :CocConfig and pasting the next json obj that is in the
" repository
Plug 'prettier/vim-prettier', { 'do': 'yarn install' } " Prettier for code formatting
Plug 'TaDaa/vimade'                              " Dim inactive windows
Plug 'sheerun/vim-polyglot'                      " Better syntax folding
Plug 'pseewald/vim-anyfold'                      " Intelligent folding
Plug 'terryma/vim-multiple-cursors'              " Multiple cursors

call plug#end()

"////////// FUNCTIONS ///////////
" Enable Emmet for all file types
let g:user_emmet_install_global = 1
autocmd FileType html,css EmmetInstall

" Use <Tab> and <S-Tab> to navigate completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <CR> to confirm completion
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

"////////// FORMATTING ///////////
" Automatically format code on save
autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx,*.html,*.css Prettier

"////////// THEME ///////////
colorscheme industry

"////////// COLORS ///////////
" Fix popup menu background and text colors
highlight Pmenu guibg=#1e1e2e guifg=#cdd6f4
highlight PmenuSel guibg=#81a1c1 guifg=#1e1e2e
highlight PmenuSbar guibg=#2e3440
highlight PmenuThumb guibg=#81a1c1

" Fix Coc.nvim highlighting for suggestions
highlight CocMenuSel guibg=#81a1c1 guifg=#1e1e2e
highlight CocFloating guibg=#1e1e2e guifg=#cdd6f4
highlight CocErrorSign guibg=#1e1e2e guifg=#bf616a
highlight CocWarningSign guibg=#1e002e guifg=#ebcb8b
highlight CocHintSign guibg=#1e1e2e guifg=#a3be8c
highlight CocInfoSign guibg=#1e1e2e guifg=#88c0ff
highlight CocHighlightText guibg=#3b4252 guifg=#cdd6f4

" General UI tweaks for better readability
highlight Normal guibg=#1e1e2e guifg=#cdd6f4
highlight LineNr guifg=#4c566a
highlight CursorLineNr guifg=#81a1c1

" NERDTree colors
highlight NERDTreeFile ctermfg=White guifg=#ebdbb2
highlight NERDTreeDir ctermfg=Blue guifg=#83a598
highlight NERDTreeDirSlash ctermfg=Blue guifg=#83a598
highlight NERDTreeOpenable ctermfg=Yellow guifg=#fabd2f
highlight NERDTreeClosable ctermfg=Red guifg=#fb4934

"////////// CTAGS ///////////
" Set the ctag file relative to the project open
set tags=./tags;
