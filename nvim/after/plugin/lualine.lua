require('lualine').setup({
    options = {
        theme = 'ayu_mirage'
    },
    sections = {
        lualine_a = {'mode', 'PencilMode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    }
    -- tabline = {
    --     lualine_a = {'buffers'},
    --     lualine_b = {},
    --     lualine_c = {{'filename', file_status = true, path = 1}},
    --     lualine_x = {},
    --     lualine_y = {},
    --     lualine_z = {'tabs'}
    -- }
})
