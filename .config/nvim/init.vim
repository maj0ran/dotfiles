" ---------- NeoVim Configuration File ----------
" (C) Marian Cichy
" License: GPL2.0-or-later
" -----------------------------------------------

" ----- Plugins -----

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
call plug#begin()
" intern
Plug 'intern@intern.scm.pengutronix.de:/ptx-vim-syntax.git', " PTX files syntax
Plug 'privat@privat.scm.pengutronix.de:fsc/vim-ptx-timesheet.git'
" extern
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " Treebar
Plug 'yuttie/comfortable-motion.vim' " smooth scrolling
"Plug 'vim-airline/vim-airline' " better info bar
Plug 'tikhomirov/vim-glsl' " Syntax highlighting for GLSL files
Plug 'jceb/vim-orgmode' " ToDo-List in orgformat
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'rhysd/vim-clang-format' " Format C-Family Code
call plug#end()


" ----- airline configuration -----
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1


" ----- Keymaps -----
nnoremap <SPACE> <Nop>
map <SPACE> <Leader>

" make tab in v mode indent code
xmap <tab> >gv
xmap <s-tab> <gv

" back-tab in insert mode
imap <S-tab> <C-d>

" Buffer Handling
set hidden
nnoremap  <silent>   <tab>  :bnext<CR>
nnoremap  <silent> <s-tab>  :bprevious<CR>
nnoremap Z<tab> :bdelete<CR>
" jump to last buffer
nnoremap <silent> <leader><tab> :b#<cr>

" x not overwriting clipboard
nnoremap x "_x
nnoremap X "_X
xnoremap x "_x
xnoremap X "_X

" accumulate yanks instead of overwriting
nnoremap <leader>y "Ayy
nnoremap <leader>d "Add
nnoremap <leader>Y "ayy

" ----- Commands -----
:command Tree NERDTreeToggle

" ----- Tab Settings -----
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set autoindent
set expandtab
set smarttab

	" --- Python ---
	au BufNewFile,BufRead *.py
	    \ set tabstop=4 |
	    \ set shiftwidth=4 |

" ----- Clipboard -----
set clipboard+=unnamedplus

" ----- Scrolling -----
set scrolloff=5
set sidescrolloff=5

" ----- Visual / UI -----
set showbreak=↪ " this if for looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong lines
set list " shows tabs as >
set listchars=tab:ᐅ·
set colorcolumn=100


" ----- Syntax Highlighting -----

syntax on

hi Special ctermfg=yellow
hi Statement ctermfg=yellow
hi Type ctermfg=green
hi ExtraWhitespace ctermbg=red guibg=red
hi Statement cterm=bold
hi Comment cterm=bold
hi ErrorMsg ctermfg=red ctermbg=none
hi Pmenu ctermbg=white ctermfg=black
hi PmenuSel ctermbg=blue ctermfg=white
match ExtraWhitespace /\s\+$/
"source $HOME/.config/nvim/meson.vim

" ----- Spell check -----

set spelllang=en
nnoremap <silent> <F10> :set spell!<cr>
inoremap <silent> <F10> <C-O>:set spell!<cr>


" ----- General Settings -----

set encoding=utf-8
set splitbelow
set splitright

" ----- Language Server -----

lua require'lspconfig'.clangd.setup{on_attach=require'completion'.on_attach}
autocmd BufEnter * lua require'completion'.on_attach()
"lua require'lspconfig'.clangd.setup{}
set omnifunc=v:lua.vim.lsp.omnifunc

lua << EOF
vim.lsp.set_log_level("debug")
EOF


nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

map <C-K> :pyf /usr/share/clang/clang-format.py<cr>
let g:python3_host_prog='/usr/bin/python'

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" ----- lightline -----
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }

autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()
set showtabline=2
