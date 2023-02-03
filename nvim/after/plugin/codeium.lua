vim.g.codeium_enabled = false;

vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, {expr = true})
vim.keymap.set('n', '<leader>ai', function()
    if vim.g.codeium_enabled == 1 then
        vim.cmd('Codeium Disable')
        print('Disabled Codeium')
    else
        vim.cmd('Codeium Enable')
        print('Enabled Codeium')
    end
end)
