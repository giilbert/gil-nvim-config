imap <C-BS> <C-W>

augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END

set number
set relativenumber
set termguicolors
set updatetime=1000 
set signcolumn=yes
set smartindent
set mouse=a
set guifont=FiraCode\ Nerd\ Font\ Mono:h11

nmap <silent> <c-s> :w<CR>
imap <silent> <c-s> <Esc>:w<CR>a

lua require("init")

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

if has('wsl')
    let g:clipboard = {
          \   'name': 'wslclipboard',
          \   'copy': {
          \      '+': '/mnt/c/win32yank.exe -i --crlf',
          \      '*': '/mnt/c/win32yank.exe -i --crlf',
          \    },
          \   'paste': {
          \      '+': '/mnt/c/win32yank.exe -o --lf',
          \      '*': '/mnt/c/win32yank.exe -o --lf',
          \   },
          \   'cache_enabled': 1,
          \ }
endif

nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap fs <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>

autocmd BufRead,BufEnter *.astro set filetype=astro

highlight NeoTreeNormal guifg=#a7aab0 guibg=#222222
highlight NeoTreeNormalNC guifg=#a7aab0 guibg=#222222
highlight NeoTreeEndOfBuffer guifg=#222222 guibg=#222222
