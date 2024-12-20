"////////// Before plugins installations ////////
" first install vim > sudo pacman -S vim
"////////// Some plugins need nodejs
" sudo pacman -S nodejs npm 
"////////// if we use vim-pretier we need yarn
" sudo pacman -S yarn
"////////// Now install vim-plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"////////// Now on vim
" PlugInstall
" Afte this all the plugins will be installer


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
"Tab to autocomplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


"///////// PLUGIN VARS /////////
" Example: Adjusting vimade fade level
let g:vimade = { 'fadelevel': 0.7 }


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


"/////////////// CTAGS (TO JUMP TO DEFINITIONS)//////////////
"set the ctag file relative to the project open
set tags=./tags;
