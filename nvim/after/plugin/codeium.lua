vim.g.codeium_enabled = 1;
vim.g.codeium_disable_bindings = 0;
vim.g.codeium_no_map_tab = 1;

vim.keymap.set('i', '<C-i>', function() return vim.fn['codeium#Accept']() end, {expr = true})
vim.keymap.set('n', '<leader>ai', function()
    if vim.g.codeium_enabled == 1 then
        vim.cmd('CodeiumDisable')
        print('Disabled Codeium')
    else
        vim.cmd('CodeiumEnable')
        print('Enabled Codeium')
    end
end)
