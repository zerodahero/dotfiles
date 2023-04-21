-- Wordy, ditto, etc
local proseGroup = vim.api.nvim_create_augroup('prose', {clear = true})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'markdown', 'text', 'tex'},
    group = proseGroup,
    command = 'DittoOn',
})
vim.keymap.set('n', '<leader>di', '<Plug>ToggleDitto')

vim.g['pencil#wrapModeDefault'] = 'soft'
vim.g['pencil#cursorwrap'] = 0
vim.g['pencil#conceallevel'] = 0
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'markdown', 'text', 'tex'},
    group = proseGroup,
    command = 'call pencil#init()',
})
