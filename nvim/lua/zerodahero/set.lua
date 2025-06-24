vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.cursorline = true

vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

vim.opt.updatetime = 50

vim.opt.colorcolumn = '100'

vim.opt.clipboard:append{'unnamed'}

vim.cmd([[
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup=(vim.fn['hlexists']('HighlightedyankRegion') > 0 and 'HighlightedyankRegion' or 'IncSearch'), timeout=200}
]])

vim.opt.hidden = true

vim.g.netrw_liststyle = 3

vim.opt.spell = true
vim.opt.spelllang = 'en_us'
vim.opt.spellsuggest = 'best,9'

vim.opt.laststatus = 2

vim.g.load_doxygen_syntax = 1
vim.g.doxygen_enhanced_color = 1

vim.g.editorconfig = true
vim.g.EditorConfig_exclude_patterns = {'fugitive://.*', 'scp://.*'}

vim.g.surround_no_insert_mappings = 1

vim.opt.fileignorecase = false

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Kitty fix
if vim.env.TERM == 'xterm-kitty' then
  vim.cmd([[autocmd UIEnter * if v:event.chan ==# 0 | call chansend(v:stderr, "\x1b[>1u") | endif]])
  vim.cmd([[autocmd UILeave * if v:event.chan ==# 0 | call chansend(v:stderr, "\x1b[<1u") | endif]])
end
