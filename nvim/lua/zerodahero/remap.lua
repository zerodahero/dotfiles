vim.g.mapleader = ","

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>mf", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>s", [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

-- Save
vim.keymap.set("i", "<C-s>", "<C-o>:update<CR>")
vim.keymap.set("n", "<C-s>", ":<C-u>update<CR>")

-- Simple mappings to switch between splits.
vim.keymap.set("n", "<C-J>", "<C-W><C-J>")
vim.keymap.set("n", "<C-K>", "<C-W><C-K>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
vim.keymap.set("n", "<C-L>", "<C-W><C-L>")
vim.keymap.set("n", "<C-W>Z", "<C-W>| <C-W>_")
vim.keymap.set("n", "<C-W>z", "<C-W>=")

-- autosave
vim.keymap.set('n', '<leader>ns', ':ASToggle<CR>')

-- semi-colon me!
vim.keymap.set("n", "<leader>;", [[:s/[^;]\zs$/;/<CR>:nohl<CR>$]], { silent = true })

-- indents
vim.keymap.set('v', '>', ">gv", { noremap = true })
vim.keymap.set('n', '>', ">>", { noremap = true })
vim.keymap.set('v', '<lt>', "<gv", { noremap = true })
vim.keymap.set('n', '<lt>', "<<", { noremap = true })

-- winresizer
vim.g.winresizer_start_key = "<leader>w"

-- Pencil
vim.keymap.set('n', '<leader>md', ':PencilToggle<CR>')
-- ZenMode
vim.keymap.set('n', '<leader>mz', ':ZenMode<CR>')

-- No whitespace
-- vim.keymap.set('n', '<leader>ds', ':TrailerTrim<CR>')
vim.keymap.set('n', '<leader>ds', function () require('mini.trailspace').trim() end)

-- buffers
vim.keymap.set('n', 'L', ':bnext<cr>', { silent = true })
vim.keymap.set('n', 'H', ':bprev<cr>', { silent = true })

-- Delete current buffer and goes back to the previous one
vim.keymap.set('n', '<Leader>qq',':Bdelete<cr>', { silent = true })
vim.keymap.set('n', '<Leader>wq', function ()
    vim.cmd('update')
    vim.cmd('Bdelete')
end, { silent = true })
vim.keymap.set('n', '<Leader>qa',function()
    vim.cmd(':bufdo :Bdelete')
    vim.cmd(':NvimTreeFocus')
end, { silent = true })

vim.g.doge_mapping = '<leader>db'
