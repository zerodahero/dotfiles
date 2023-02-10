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
api.events.subscribe(api.events.Event.FileCreated,
                     function(file) vim.cmd("edit " .. file.fname) end)

local function open_nvim_tree(data)
    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1

    if not directory then return end

    -- change to the directory
    vim.cmd.cd(data.file)

    -- open the tree
    require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({"VimEnter"}, {callback = open_nvim_tree})

vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and
            require("nvim-tree.utils").is_nvim_tree_buf() then
            vim.cmd.NvimTreeFocus()
        end
    end
})
