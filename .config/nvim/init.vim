"==================================================================================================
" PYTHON VIRTUAL ENVIRONMENT
"==================================================================================================
let g:python3_host_prog='$XDG_CACHE_HOME/nvim-venv/bin/python3'

"==================================================================================================
" PLUG.VIM PLUGIN MANAGER
"==================================================================================================
call plug#begin('~/.local/share/nvim/plugged')
" auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" colour toggle
Plug 'rakr/vim-togglebg'
" colour schemes 
Plug 'ayu-theme/ayu-vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'mhartington/oceanic-next'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'rakr/vim-one'
Plug 'sainnhe/gruvbox-material'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'cocopon/iceberg.vim'
" fzf
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" nerdtree
Plug 'scrooloose/nerdtree'
" tpope: comment toggle, git
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
" jsx plugin
Plug 'maxmellon/vim-jsx-pretty'
call plug#end()

"==================================================================================================
" BASIC VIM SETTINGS
"==================================================================================================
" basic vim settings
syntax enable
filetype plugin indent on
set number
set relativenumber
set tabstop=4                 "number of spaces for a tab
set shiftwidth=4              "number of spaces for a >>
"set expandtab                 "space characters when tab is pressed
set signcolumn=yes            "left side errors always visible
set hidden                    "change to other file without saving
" spelling
setlocal spelllang=en_gb
autocmd FileType gitcommit setlocal spell  "enable spell git commits

" live substitution
set inccommand=split     

" toggle spelling, wrapping, invisibles
nmap <leader>s : set spell!<CR>
nmap <leader>w : set wrap!<CR>
nmap <leader>j : set list!<CR>
"set listchars=tab:►\ ,trail:*,eol:¬,space:·
"set listchars=tab:»·\ ,trail:*,eol:¬,space:·,
set listchars=tab:›\ ,trail:*,eol:¬,space:·,


" remove highlight after search
nmap <leader>\ : nohlsearch<CR>

" automatic line wrapping 
autocmd FileType markdown,text setlocal tw=100
autocmd FileType tex setlocal tw=118

" set tabwidth and shiftwidth
nmap <leader>2 : set ts=2 sw=2<CR>
nmap <leader>4 : set ts=4 sw=4<CR>
nmap <leader>8 : set ts=8 sw=8<CR>

command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g

"==================================================================================================
" COC.NVIM
"==================================================================================================
" diagnostic message updates
set updatetime=300

" use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

"==================================================================================================
" NERDTREE
"==================================================================================================
" nerdtree shortcut key
nmap <leader>o :NERDTreeToggle<CR>
set splitright
set splitbelow

"==================================================================================================
" 80 LINE LIMIT
"==================================================================================================
augroup vimrc_autocmds
	autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#111111
	autocmd BufEnter *.cpp,*.hpp,*.c,*.h match OverLength /\%101v.*/
	autocmd BufEnter *.tex,*.md match OverLength /\%120v.*/
augroup END

"==================================================================================================
" FZF
"==================================================================================================
" Command for git grep
command! -bang -nargs=* GGrep
	\ call fzf#vim#grep(
	\   'git grep --line-number '.shellescape(<q-args>), 0,
	\   fzf#vim#with_preview({ 'dir': systemlist('git rev-parse --show-toplevel')[0] }), <bang>0)

" Rg without searching filename
command! -bang -nargs=* ZRg
	\ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1,
	\ fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" Ag without searching filename
command! -bang -nargs=* ZAg 
	\ call fzf#vim#ag(<q-args>,
	\ fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" fzf shortcuts
nmap <leader>f :Files<CR>
nmap <leader>a :ZAg<CR>
nmap <leader>r :ZRg!<CR>
nmap <leader>b :Buffers<CR>

"==================================================================================================
" COLOUR SETTINGS
"==================================================================================================
set termguicolors " true colour display and colour schemes

set background=dark
"colorscheme palenight

"colorscheme one
"let g:one_allow_italics=1

"colorscheme solarized8_flat

"let ayucolor="light"  " for light version of theme
"let ayucolor="mirage" " for mirage version of theme
"let ayucolor="dark"   " for dark version of theme
"colorscheme ayu

"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
"colorscheme OceanicNext

"let g:gruvbox_material_background = 'hard'
"colorscheme gruvbox-material

"colorscheme iceberg

colorscheme onehalfdark

"colorscheme angr

call togglebg#map("<F5>")
