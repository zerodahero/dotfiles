-- examples for your init.lua
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup({
    actions = {open_file = {quit_on_open = true}},
    git = {ignore = false}
})

-- Keys
vim.keymap.set("n", "<leader>tc", ":NvimTreeCollapse<CR>")
vim.keymap.set("n", "<leader>tm", ":NvimTreeFindFile<CR>")
vim.keymap.set('n', '<C-Bslash>', function()
    local bufName = vim.fn.expand('%')
    if string.len(bufName) == 0 then
        vim.cmd.NvimTreeFocus()
    elseif string.find(bufName, 'NvimTree_%d') then
        vim.cmd.NvimTreeToggle()
    else
        vim.cmd.NvimTreeFindFile()
    end
end)

local api = require("nvim-tree.api")
api.events.subscribe(api.events.Event.FileCreated, function(file)
  vim.cmd("edit " .. file.fname)
end)
