require('formatter').setup {
    logging = true,
    log_level = vim.log.levels.WARN,

    filetype = {
        lua = {require('formatter.filetypes.lua').luaformat},

        javascript = {require('formatter.filetypes.javascript').prettier},

        typescript = {require('formatter.filetypes.typescript').prettier},

        ['*'] = {
            require('formatter.filetypes.any').remove_trailing_whitespace,
        },
    },
}
