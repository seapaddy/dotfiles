"=======================================================
" PYTHON VIRTUAL ENVIRONMENT
"=======================================================
let g:python3_host_prog="$XDG_CACHE_HOME/virtual-envs/neovim/bin/python3"

"=======================================================
" PLUG.VIM PLUGIN MANAGER
"=======================================================
call plug#begin('~/.local/share/nvim/plugged')
" autocompletion
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
" nerdtree
Plug 'scrooloose/nerdtree'
" colorschemes 
Plug 'ayu-theme/ayu-vim'
Plug 'mhartington/oceanic-next'
Plug 'rakr/vim-togglebg'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'rakr/vim-one'
Plug 'lifepillar/vim-solarized8'
Plug 'sainnhe/gruvbox-material'
" fzf
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" additional
Plug 'tpope/vim-commentary'
" git
Plug 'tpope/vim-fugitive'
" rust
Plug 'rust-lang/rust.vim'
call plug#end()

"=====================================================================
" BASIC VIM SETTINGS
"=====================================================================
" basic vim settings
syntax enable
filetype plugin indent on
set number
set relativenumber
set tabstop=4                 "number of spaces for a tab
set shiftwidth=4              "number of spaces for a >>
set expandtab                 "space characters when tab is pressed
set signcolumn=yes            "left side errors always visible
" spelling
setlocal spelllang=en_gb
autocmd FileType gitcommit setlocal spell

" toggle spelling, wrapping, invisibles
nmap <leader>s : set spell!<CR>
nmap <leader>w : set wrap!<CR>
nmap <leader>j : set list!<CR>
"set listchars=tab:►\ ,trail:_,eol:¬,space:•
set listchars=tab:►\ ,trail:*,eol:¬,space:·

"remove highlight after search
nmap <leader>\ : set nohlsearch!<CR>

" line wrapping 
autocmd FileType markdown,text setlocal tw=100

"=====================================================================
" COLOR SETTINGS
"=====================================================================
set termguicolors " true color display and colorschemes

set background=dark
"colorscheme palenight

"colorscheme one
"let g:one_allow_italics=1

"colorscheme solarized8_flat

"let ayucolor="light"  " for light version of theme
let ayucolor="mirage" " for mirage version of theme
"let ayucolor="dark"   " for dark version of theme
colorscheme ayu

"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
"colorscheme OceanicNext

"let g:gruvbox_material_background = 'medium'
"colorscheme gruvbox-material

call togglebg#map("<F5>")

"=====================================================================
" COC.NVIM
"=====================================================================
" diagnostic message updates
set updatetime=300

" use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

"=====================================================================
" NERDTREE
"=====================================================================
" nerdtree shortcut key
nmap <leader>o :NERDTreeToggle<CR>
set splitright
set splitbelow

"=====================================================================
" 80 LINE LIMIT
"=====================================================================
augroup vimrc_autocmds
    autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#111111
    autocmd BufEnter *.cpp,*.hpp,*.c,*.h match OverLength /\%101v.*/
    autocmd BufEnter *.md match OverLength /\%120v.*/
augroup END

"=====================================================================
" FZF
"=====================================================================
" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Ag and Rg don't search filename
command! -bang -nargs=* Rg 
    \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1,
    \ {'options': '--delimiter : --nth 4..'}, <bang>0)

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" open Files, Ag
nmap <leader>f :Files<CR>
nmap <leader>a :Ag<CR>
nmap <leader>r :Rg<CR>
nmap <leader>b :Buffers<CR>
