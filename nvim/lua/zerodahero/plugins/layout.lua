return {

    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", opt = true } },
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
