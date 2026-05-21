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
        "jmbuhr/otter.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {},
    },
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        dependencies = {
            "saghen/blink.cmp",
        },
        opts = function()
            local presets = require('markview.presets')
            return {
                markdown = {
                    headings = presets.headings.arrowed,
                    -- list_items = {
                        -- shift_width = 0,
                        -- add_padding = false,
                        -- marker_minus = { text = "•" },
                        -- marker_plus = { text = "•" },
                        -- marker_star = { text = "•" },
                    -- },
                },
            }
        end,
        keys = {
            { "<leader>mh", "<cmd>Markview HybridToggle<cr>", desc = "Markdown Hybrid Toggle" },
            { "<leader>mt", "<cmd>Markview Toggle<cr>", desc = "Markdown Render Toggle" },
        },
    },
    {
        "selimacerbas/markdown-preview.nvim",
        dependencies = { "selimacerbas/live-server.nvim" },
        ft = { "markdown" },
        opts = {
            instance_mode = "takeover",
            port = 0,
            open_browser = true,
            debounce_ms = 300,
            mermaid_renderer = "rust",
        },
        keys = {
            { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview" },
        },
    },
}
