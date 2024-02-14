require('formatter').setup {
    logging = true,
    log_level = vim.log.levels.WARN,

    filetype = {
        lua = {require('formatter.filetypes.lua').luaformat},

        javascript = {
            require('formatter.filetypes.typescript').eslint_d,
            -- require('formatter.filetypes.typescript').prettier,
        },

        json = {require('formatter.filetypes.json').fixjson},

        rust = {require('formatter.filetypes.rust').rustfmt},

        typescript = {
            require('formatter.filetypes.typescript').eslint_d,
            -- require('formatter.filetypes.typescript').prettier,
        },

        ['*'] = {require('formatter.filetypes.any').remove_trailing_whitespace},
    },
}
