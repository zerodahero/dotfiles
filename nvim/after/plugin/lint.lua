local lint = require('lint')

-- lint.linters_by_ft = {javascript = {'eslint'}, typescript = {'eslint'}}

vim.api.nvim_create_autocmd({'BufWritePost'}, {
    group = vim.api.nvim_create_augroup('lint', {clear = true}),
    callback = function()
        lint.try_lint()
        lint.try_lint('cspell')
    end,
})

