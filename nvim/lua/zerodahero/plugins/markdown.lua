return {
    -- {
    --     "MeanderingProgrammer/render-markdown.nvim",
    --     dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
    --     ---@module 'render-markdown'
    --     ---@type render.md.UserConfig
    --     ft = { "markdown", "codecompanion" },
    --     opts = {
    --         code = {
    --             border = "thick",
    --         },
    --         checkbox = {
    --             -- bullet = true,
    --         },
    --         completions = { blink = { enabled = true } },
    --     },
    -- },
    {
        "OXY2DEV/markview.nvim",
        lazy = false,

        -- For `nvim-treesitter` users.
        priority = 49,

        dependencies = {
            "saghen/blink.cmp"
        },
        opts = {
            markdown = {
                code_blocks = {
                    label_direction = "left"
                }
            }
        }
    },
    -- {
    --     "iamcco/markdown-preview.nvim",
    --     cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    --     build = "cd app && npm install && git restore .",
    --     keys = {
    --         { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
    --     },
    --     init = function()
    --         vim.g.mkdp_filetypes = { "markdown" }
    --     end,
    --     ft = { "markdown" },
    -- },
    {
        "jannis-baum/vivify.vim",
        keys = {
            { "<leader>mp", ":Vivify<cr>", desc = "Markdown Preview" },
        },
    }
}
