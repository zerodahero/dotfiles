require("lualine").setup({
    options = {
        -- theme = "ayu_mirage"
        theme = "auto"
    },
    sections = {
        lualine_a = { "mode", "PencilMode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
            -- 'filename',
            "navic",
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    extensions = {
        "nvim-tree",
        "trouble",
    },
    -- tabline = {
    --     lualine_a = {'buffers'},
    --     lualine_b = {},
    --     lualine_c = {{'filename', file_status = true, path = 1}},
    --     lualine_x = {},
    --     lualine_y = {},
    --     lualine_z = {'tabs'}
    -- }
})
