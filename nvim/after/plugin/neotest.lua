require('neotest').setup({
    output = {enabled = true, open_on_run = ''},
    adapters = {
        require('neotest-phpunit')({
            phpunit_cmd = function()
                local stdPhpunit = vim.fn.glob('vendor/bin/phpunit');
                if stdPhpunit == nil or stdPhpunit == '' then
                    -- Not the usual path, try and find it
                    return vim.fn.globpath('.', '**/vendor/bin/phpunit')
                else
                    return stdPhpunit
                end
            end,
        }),
        require('neotest-dotnet'),
        require('neotest-jest'),
    },
})

local neotest = require('neotest')
vim.keymap.set('n', '<leader>tt', function() neotest.run.run() end)
vim.keymap.set('n', '<leader>tf', function() neotest.run.run(vim.fn.expand('%')) end)
vim.keymap.set('n', '<leader>tp', function() neotest.output_panel.toggle() end)
vim.keymap.set('n', '<leader>to', function() neotest.output.open() end)
vim.keymap.set('n', '<leader>ts', function() neotest.summary.toggle() end)
