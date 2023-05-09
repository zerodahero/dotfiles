local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup {
    pickers = {
        find_files = {
            hidden = true,
            no_ignore = false,
            path_display = {'truncate'},
        },
        oldfiles = {sort_mru = true, ignore_current_buffer = true},
        live_grep = {
            additional_args = {
                "-i"
            }
        }
    },
    extensions = {
        -- repo = { list = { search_dirs = { "~/projects" } } }
        ['ui-select'] = {
            require('telescope.themes').get_dropdown({width = 0.8}),
        },
    },
    defaults = {
        layout_strategy = 'center',
        sorting_strategy = 'ascending',
        selection_strategy = 'closest',
        scroll_strategy = 'limit',
        mappings = {i = {['<esc>'] = require'telescope.actions'.close}},
    },
}

telescope.load_extension('luasnip')
telescope.load_extension('ui-select')
telescope.load_extension('lsp_handlers')
telescope.load_extension('dap')

-- vim.keymap.set('n', '<leader>ft', function()
--     vim.fn.system('git rev-parse --is-inside-work-tree')
--     if vim.v.shell_error == 0 then
--         builtin.git_files()
--     else
--         builtin.find_files()
--     end
-- end, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fj', builtin.jumplist, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fc', builtin.commands, {})
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope luasnip<cr>', {silent = true})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
-- Attempts to find the matching test or file
vim.keymap.set('n', '<leader>ft', function()
    local filename = vim.fn.expand('%:t:r')
    if filename:sub(-#'Test') == 'Test' then
        builtin.find_files({default_text = filename:sub(0, -5)})
    else
        builtin.find_files({default_text = filename .. 'Test'})
    end
end, {})

vim.keymap.set('n', '<leader>ss', builtin.spell_suggest, {})
vim.keymap
    .set('n', '<leader>fp', telescope.extensions.find_pickers.find_pickers)
vim.keymap.set('n', '<leader>fn', '<cmd>TodoTelescope<cr>', {silent = true})
vim.keymap.set('n', '<leader>fd', telescope.extensions.dict.synonyms)
vim.keymap.set('n', '<leader>fY', builtin.lsp_workspace_symbols, {})
vim.keymap.set('n', '<leader>fy', builtin.lsp_document_symbols, {})
