"////////// NOTES ///////////
"PYTHON
"Some of the plugins relay on python install python3 for vim apt install vim-nox / on arch remember to use pacman

"/////// GRAL SETTINGS //////
"Line numbers
set number
set relativenumber

"////// 
"Auto start command for anyfold function (fold the functions and blocks
"of code
"/////////
autocmd FileType * AnyFoldActivate
"anyfold settings
set foldmethod=syntax  " or 'manual' if you want to control folding yourself
set foldlevelstart=7  " Open folds when opening a file
set foldlevel=7       " Ensure folds remain open

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

"These commands are to exit the file
nnoremap <C-q> :q<CR>
inoremap <C-q> <Esc>:q<CR>a

"This is for NERDTree toggle show and hide
nnoremap <C-A-n> :NERDTreeToggle<CR>
nnoremap <S-F2> :NERDTreeToggle<CR>

"This enable the popup for coc.nvim definitions
nnoremap K :call CocActionAsync('doHover')<CR>

"///////// PLUGIN VARS /////////
" Example: Adjusting vimade fade level
let g:vimade = { 'fadelevel': 0.9 }

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
"Before using popups function you need to install the servers for the used
"languages coc-<name of language server>, in my case:
":CocInstall coc-tsserver
":CocInstall coc-html coc-css coc-tailwindcss
":CocInstall coc-pyright

Plug 'prettier/vim-prettier', { 'do': 'yarn install' } " Prettier for code formatting
Plug 'neoclide/coc.nvim', {'branch':'release'}
Plug 'TaDaa/vimade'

" for tailwind 
Plug 'airblade/vim-tailwind'

" Install vim-polyglot for better syntax folding
Plug 'sheerun/vim-polyglot'

" Install vim-anyfold for intelligent folding
Plug 'pseewald/vim-anyfold'

Plug 'terryma/vim-multiple-cursors'
" How to use the mutiple cursors on vim
" **Basic Usage**
" **2. Start Selecting Multiple Cursors**
" Ctrl + N`** → Select the word under the cursor and add another occurrence.
" Ctrl + X`** → Skip the current occurrence and go to the next one.
" Ctrl + P`** → Go back to the previous occurrence.
" Esc`** → Exit multiple cursors mode.
"
" **2. Manual Selection**
" **Visual Mode (`v`)** → Select text.
" Press **`Ctrl + N`** to create multiple cursors for the selected text.
"
" **3. Select All Occurrences**
" Move the cursor to a word and press **`Ctrl + N`** repeatedly.
" Or use **`Ctrl + A`** to select all occurrences in the file.
"
" **4. Editing with Multiple Cursors**
" Once multiple cursors are active, just **type as usual**.
" Every cursor will type the same text.
" You can use **normal mode commands**, such as `x` to delete, `ciw` to change words, or `A` to append.
"
" **Example Workflows**
" **Change all instances of a word**
" 1. Place the cursor on a word.
" 2. Press **`Ctrl + N`** repeatedly to select occurrences.
" 3. Press **`c`** to change the word.
" 4. Type the new word and press **`Esc`**.
"
" **Insert text at multiple locations**
" 1. Select multiple lines by going to a word and pressing `Ctrl + N` multiple times.
" 2. Press **`I`** (capital i) to insert at the beginning.
" 3. Type the new text and press **`Esc`**.

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


"////////////// theme //////////////
colorscheme industry 

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
highlight CocWarningSign guibg=#1e002e guifg=#ebcb8b
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
