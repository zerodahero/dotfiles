local nightfox = require('nightfox')

nightfox.setup({
    options = {
        transparent = false,
        dim_inactive = false,
        inverse = {visual = true, match_paren = false, search = false},
    },
})
nightfox.compile()

vim.cmd('colorscheme carbonfox')
