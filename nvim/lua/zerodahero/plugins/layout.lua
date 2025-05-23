return {

    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            options = {
                -- theme = "ayu_mirage"
                theme = "auto",
            },
            sections = {
                lualine_a = { "mode", "PencilMode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = {
                    -- 'filename',
                    "navic",
                },
                lualine_x = {
                    "encoding",
                    "fileformat",
                    "filetype",
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            extensions = {
                "nvim-tree",
                "trouble",
                "mason",
                "lazy",
            },
            -- tabline = {
            --     lualine_a = {'buffers'},
            --     lualine_b = {},
            --     lualine_c = {{'filename', file_status = true, path = 1}},
            --     lualine_x = {},
            --     lualine_y = {},
            --     lualine_z = {'tabs'}
            -- }
        },
    },
    { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },

    {
        "nvim-focus/focus.nvim",
        version = "*",
        config = function()
            local focus = require("focus")
            focus.setup({
                autoresize = {
                    minwidth = 10,
                    minheight = 5,
                },
            })
            vim.g.focus_maximised = false

            -- Focus toggle
            vim.keymap.set("n", "<c-w>z", function()
                if vim.g.focus_maximised then
                    focus.resize("autoresize")
                    vim.g.focus_maximised = false
                else
                    focus.resize("maximise")
                    vim.g.focus_maximised = true
                end
            end, { noremap = true })

            vim.keymap.set("n", "<c-w>=", function()
                vim.g.focus_maximised = true
                focus.resize("equalise")
            end, { noremap = true })

            local ignore_filetypes = { "NvimTree" }
            vim.api.nvim_create_autocmd("FileType", {
                group = augroup,
                callback = function(_)
                    if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
                        vim.b.focus_disable = true
                    else
                        vim.b.focus_disable = false
                    end
                end,
                desc = "Disable focus autoresize for FileType",
            })
        end,
    },

    { "simeji/winresizer" },
    {
        "nvim-zh/colorful-winsep.nvim",
        config = true,
        event = { "WinLeave" },
    },
    { "kwkarlwang/bufresize.nvim" },

    -- Little floating window with file name
    { "b0o/incline.nvim" },

    -- Buffer closing without closing windows
    { "moll/vim-bbye" },
    { "arithran/vim-delete-hidden-buffers" },

    { "folke/twilight.nvim", opts = {} },
    { "folke/zen-mode.nvim", opts = {} },
}
