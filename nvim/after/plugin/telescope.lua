local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup {
  extensions = {
    repo = {
      list = {
        search_dirs = {
          "~/projects",
        },
      },
    },
  },
}


telescope.load_extension('repo')

vim.keymap.set('n', '<leader>ft', builtin.git_files, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fj', builtin.jumplist, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fp', '<cmd>Telescope repo list<cr>', {})
vim.keymap.set('n', '<leader>fc', builtin.commands, {})

