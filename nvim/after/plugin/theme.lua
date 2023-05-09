local nightfox = require('nightfox')

nightfox.setup({
    options = {dim_inactive = false},
})
nightfox.compile()

vim.cmd('colorscheme carbonfox')

