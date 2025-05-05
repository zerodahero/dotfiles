return {

    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", opt = true } },
    { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },

    { "nvim-focus/focus.nvim", version = "*", opts = {}},

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
