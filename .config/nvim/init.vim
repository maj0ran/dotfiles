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
Plug 'wojciechkepka/bogster' " Color-scheme bogster
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

lua << EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "clangd", "pyright", "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Use <Tab> and <S-Tab> to navigate through popup menu
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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

colorscheme bogster
