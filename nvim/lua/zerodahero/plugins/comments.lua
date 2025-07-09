return {

    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        opts = { enable_autocmd = false },
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
                opleader = {
                    line = "gcc",
                },
            })
            local ft = require("Comment.ft")
            ft.set("vhs", "# %s")
        end,
    },
    -- {
    --     "folke/ts-comments.nvim",
    --     opts = {
    --         lang = {
    --             nim = {
    --                 "# %s",
    --                 "## %s",
    --             }
    --         }
    --     },
    --     event = "VeryLazy",
    --     enabled = vim.fn.has("nvim-0.10.0") == 1,
    -- },
}
