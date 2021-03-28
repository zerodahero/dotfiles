"---------------------- Plugins ----------------------
if empty(glob('~/.vim/autoload/plug.vim'))          "Autoinstall plug.vim
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
Plug 'itchyny/lightline.vim'                        " Pretty status bar
Plug '/usr/local/opt/fzf'                           " Fuzzy Finder
Plug 'junegunn/fzf.vim'                             " VIM Fuzzy finder plugin
Plug 'ludovicchabant/vim-gutentags'                 " Mostly working tag generator
" Plug 'bkad/CamelCaseMotion'                         " Move around code like a boss
Plug 'ap/vim-buftabline'                            " Better tabs, trust me.
Plug 'rafi/awesome-vim-colorschemes'                " Colorschemes I always use
Plug 'editorconfig/editorconfig-vim'		        " Editorconfig
Plug 'tpope/vim-commentary'                         " Peanut gallery
Plug 'tpope/vim-dadbod'                             " DB Client
Plug 'kristijanhusak/vim-dadbod-ui'                 " more VIM DadBod
Plug 'kristijanhusak/vim-dadbod-completion'         " db autocompleteion
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " CoC - autocompletion

call plug#end()

colorscheme lucius
set t_CO=256								        "Use 256 colors. This is useful for Terminal Vim.
set guifont=JetBrainsMono-Regular:h14               "Set the default font family and size.
" set macligatures							        "We want pretty symbols, when available.
set guioptions-=e							        "We don't want Gui tabs.
set linespace=15
set backspace=indent,eol,start
set noerrorbells visualbell t_vb=

set guioptions-=l                                                       "Disable Gui scrollbars.
set guioptions-=L
set guioptions-=r
set guioptions-=R

set nocompatible                                    " Don't play with Vi
set nowrap                                          " Stop wrapping my lines for me... Thanks!
set hidden                                          " Close 'em up
set numberwidth=5                                   " Set width of number gutter
set number relativenumber                           " Show line number with relative numbers
let mapleader = ','                                 " Remap the <Leader>
set cursorline                                      " Show the cursor line
set spell                                           " Turn spell checking on
set autoread                                        " Automatically load changes to open buffers
augroup numbertoggle                                " Toggles to numbered lines in Insert
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
set noshowmode                                      " Hide current mode down the bottom
set showbreak=...                                   " Uses an elipsis when wrapping lines
set undolevels=4000                                 " Store a bunch of undo history
set showmatch                                       " Show matching brackets/parenthesis
set matchtime=0                                     " Don't blink when matching
set hlsearch                                        " Highlight search terms
set incsearch                                       " Incrementally highlight
set ignorecase                                      " Case insensitive search
set smartcase                                       " Case sensitive if we type an uppercase
set shiftwidth=4                                    " Indentation settings
set tabstop=4
set softtabstop=4
set expandtab
set tags+=~/.vim/gutentags
set mouse=a
if exists('+colorcolumn')                           " Create a dark chasm where text goes to die
    let &colorcolumn="120,".join(range(120,999),",")
endif
set nofoldenable                                    " Disable folding
autocmd FileType netrw setl bufhidden=wipe          " Close netrw buffers that aren't in use
autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
let g:netrw_fastbrowse = 0
let python_highlight_all=1
syntax on
set clipboard+=unnamed                              " Set clipboard to global, system clipboard
autocmd BufWritePre * %s/\s\+$//e                   " Autoremove trailing whitespace.
augroup autosourcing                                " Autosource vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source %
augroup END


"-------------Mappings--------------"
"Make it easy to edit the Vimrc file.
nmap <Leader>ev :tabedit $MYVIMRC<cr>
nmap <Leader>es :e ~/.vim/snippets/

"Add simple highlight removal.
nmap <Leader><space> :nohlsearch<cr>

" Show Fuzzy file search
nmap <C-t> :Files<CR>
" Show current file tags
nmap <C-r> :BTags<CR>
" Show MRU files
nmap <C-e> :History<CR>
nmap <Left> <nop>
nmap <Up> <nop>
nmap <Down> <nop>
nmap <Right> <nop>
" Fuzzy search planet earth
nmap <C-S-f> :Ag<CR>
" Quick edit zsh config
nmap <Leader>eb :tabe ~/.zshrc<CR>
" w, b, and e move between camel case words now.
" map <silent> w <Plug>CamelCaseMotion_w
" map <silent> b <Plug>CamelCaseMotion_b
" map <silent> e <Plug>CamelCaseMotion_e

" Ctrl-w closes the current buffer
nmap <C-w> :bd<CR>

"-------------Split Management--------------"
set splitbelow 								"Make splits default to below...
set splitright								"And to the right. This feels more natural.

"We'll set simpler mappings to switch between splits.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>

nnoremap <Leader>/ :normal gcc<CR>
nnoremap <Leader>; A;<Esc>

" LightLine Status Bar
let g:lightline = {
\ 'colorscheme': 'one',
\ 'active': {
\   'left':[ [ 'mode', 'paste' ],
\            [ 'gitbranch', 'readonly', 'filename', 'modified' ]
\   ]
\ },
\ 'componenet' : {
\   'lineinfo': ' %3l:%-2v',
\ },
\ 'component_function': {
\   'gitbranch': 'fugitive#head',
\ }
\ }
" FZF
let g:fzf_tags_command = 'ctags'                    " Command to generate tags file
                                                    " Show file previews in ZFZ
let g:fzf_files_options = '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()
" Gutentags
let g:gutentags_cache_dir = '~/.vim/gutentags'      " Where to store tag files
let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml',
                          \ '*.phar', '*.ini', '*.rst', '*.md',
                          \ '*vendor/*/test*', '*vendor/*/Test*',
                          \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                          \ '*var/cache*', '*var/log*']

let g:db_ui_save_location = "~/.vim/db_ui_queries"
