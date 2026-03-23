return {
    {
        "akinsho/git-conflict.nvim",
        version = "*",
        config = true,
    },

    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        opts = {
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")
                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end
                map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end)
                map("n", "<leader>hd", gitsigns.diffthis)
                map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
                map("n", "<leader>tw", gitsigns.toggle_word_diff)
            end,
        },
    },

    {
        "sindrets/diffview.nvim",
    },
}
