vim.g.codeium_enabled = false;
vim.g.codeium_disable_bindings = 0;

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
