local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup {
    pickers = {
        find_files = {no_ignore = false},
        oldfiles = {sort_mru = true, ignore_current_buffer = true}
    },
    extensions = {repo = {list = {search_dirs = {"~/projects"}}}}
}

telescope.load_extension('repo')
telescope.load_extension('luasnip')

vim.keymap.set('n', '<leader>ft', function()
    vim.fn.system('git rev-parse --is-inside-work-tree')
    if vim.v.shell_error == 0 then
        builtin.git_files()
    else
        builtin.find_files()
    end
end, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fj', builtin.jumplist, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fp', '<cmd>Telescope repo list<cr>', {})
vim.keymap.set('n', '<leader>fc', builtin.commands, {})
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope luasnip<cr>', {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
