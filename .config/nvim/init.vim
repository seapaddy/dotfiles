"===============================================================================
" PYTHON VIRTUAL ENVIRONMENT
"===============================================================================
let g:python3_host_prog='$HOME/.local/venv/bin/python3'

"===============================================================================
" PLUG.VIM PLUGIN MANAGER
"===============================================================================
call plug#begin('~/.local/share/nvim/plugged')
" treesitter colour scheme
Plug 'sainnhe/gruvbox-material'
Plug 'mhartington/oceanic-next'
Plug 'sainnhe/edge'
Plug 'eddyekofo94/gruvbox-flat.nvim'
" fzf
Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
" nerdtree
Plug 'scrooloose/nerdtree'
" tpope: comment toggle, git
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
" treesitter, lsp, completion
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
call plug#end()

"===============================================================================
" BASIC VIM SETTINGS
"===============================================================================
" basic vim settings
syntax enable
filetype plugin indent on
set number
"set relativenumber
set tabstop=4       "number of spaces for a tab
set shiftwidth=4    "number of spaces for a >>
set expandtab       "space characters when tab is pressed
set signcolumn=yes  "left side errors always visible
set hidden          "change to other file without saving
set nofoldenable    "disable folds
set mouse=a         "enable mouse use
" spelling
setlocal spelllang=en_gb

" live substitution
set inccommand=split     

" toggle spelling, wrapping, invisibles
nmap <leader>s :set spell!<CR>
nmap <leader>w :set wrap!<CR>
nmap <leader>j :set list!<CR>
set listchars=tab:›\ ,trail:*,eol:¬,space:·,

" remove highlight after search
nmap <leader>\ :nohlsearch<CR>

" set colorcolumn at line 101
set cc=101
nmap <leader>c :execute "set cc=" . (&cc == "" ? "101" : "")<CR>

" set tabwidth and shiftwidth
nmap <leader>2 :set ts=2 sw=2<CR>
nmap <leader>4 :set ts=4 sw=4<CR>
nmap <leader>8 :set ts=8 sw=8<CR>

command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g

" diagnostic message updates
set updatetime=300

"===============================================================================
" NERDTREE
"===============================================================================
" nerdtree shortcut key
nmap <leader>o :NERDTreeToggle<CR>
set splitright
set splitbelow

"===============================================================================
" FZF
"===============================================================================
" Open in split rather than floating window
let g:fzf_layout={ 'down': '50%' }
" Command for git grep
command! -bang -nargs=* GGrep
	\ call fzf#vim#grep('git grep
	\                   --line-number
	\                   -- '.shellescape(<q-args>), 0,
	\ fzf#vim#with_preview({'dir':
	\     systemlist('git rev-parse --show-toplevel')[0]}),
	\ <bang>0)

" Rg search without filename (options delimiter nth 4 only analyses 4th : )
command! -bang -nargs=* ZRg
	\ call fzf#vim#grep('rg
	\                   --column
	\                   --line-number
	\                   --no-heading
	\                   --color=always
	\                   --smart-case 
	\                   -- '.shellescape(<q-args>), 1,
	\ fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}),
	\ <bang>0)

" Ag search without filename
command! -bang -nargs=* ZAg 
	\ call fzf#vim#ag(<q-args>,
	\ fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}),
	\ <bang>0)

" fzf shortcuts
nmap <leader>f :Files<CR>
nmap <leader>g :GFiles<CR>
nmap <leader>a :ZAg<CR>
nmap <leader>r :ZRg!<CR>
nmap <leader>b :Buffers<CR>

"===============================================================================
" TREESITTER
"===============================================================================
lua <<EOF
require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
		disable = {},
	},
}
EOF

"===============================================================================
" LSP & COMPLETION
"===============================================================================
set completeopt=menuone,noinsert,noselect
set shortmess+=c

lua <<EOF
local completion_lsp_attach = function(client)
	vim.api.nvim_buf_set_keymap(0, 'n', 'K',
	    '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
	vim.api.nvim_buf_set_keymap(0, 'n', '<c-]>',
	    '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})
	vim.api.nvim_buf_set_keymap(0, 'n', 'gd',
	    '<cmd>lua vim.lsp.buf.declaration()<CR>', {noremap = true})
	vim.api.nvim_buf_set_keymap(0, 'n', 'gr',
	    '<cmd>lua vim.lsp.buf.references()<CR>', {noremap = true})

	-- disable lsp client
	vim.api.nvim_buf_set_keymap(0, 'n', '}',
	    '<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>', {noremap = true})
end

-- Auto completion compe
require'compe'.setup{
	enable = true;
	autocomplete = true;
	debug = false;
	min_length = 1;
	preselect = 'enable';
	throttle_time = 80;
	source_timeout = 200;
	incomplete_delay = 400;
	max_abbr_width = 100;
	max_kind_width = 100;
	max_menu_width = 100;
	documentation = true;

	source = {
		path = true;
		nvim_lsp = true;
		buffer = true;
	};
}

-- Haskell language server
require'lspconfig'.hls.setup{
    cmd = { "haskell-language-server-wrapper", "--lsp" },
    filetypes = { "haskell", "lhaskell" },
	on_attach=completion_lsp_attach,
}

-- CMake language server
require'lspconfig'.cmake.setup{}
	
-- C/C++ language server
require'lspconfig'.clangd.setup{
	cmd = {
		"clangd",
		"--suggest-missing-includes",
		"--clang-tidy",
		"--header-insertion=iwyu",
	},
	on_attach=completion_lsp_attach,
}

-- Rust language server
require'lspconfig'.rust_analyzer.setup{
	on_attach=completion_lsp_attach,
}

-- Typescript language server
require'lspconfig'.tsserver.setup{
	cmd = { "typescript-language-server", "--stdio" },
	on_attach=completion_lsp_attach,
}

-- Python language server
require'lspconfig'.pylsp.setup {
	on_attach=completion_lsp_attach,
}

EOF

"let g:completion_enable_auto_popup = 0
inoremap <silent><expr> <c-space> compe#complete()

"===============================================================================
" COLOUR SETTINGS
"===============================================================================
set termguicolors " true colour display and colour schemes
set background=dark

let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_background = 'hard'

let g:gruvbox_flat_style = "hard"

"colorscheme edge
"colorscheme OceanicNext
"colorscheme gruvbox-material
colorscheme gruvbox-flat

" toggle background light and dark
nmap <F5> :execute "set bg=" . (&bg == "dark" ? "light" : "dark")<CR>
