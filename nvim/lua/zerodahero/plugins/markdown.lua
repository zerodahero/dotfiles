return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        ft = { "markdown", "codecompanion" },
        opts = {
            -- Only render tables; everything else stays raw markdown.
            pipe_table = { enabled = true },
            bullet = { enabled = false },
            checkbox = { enabled = false },
            code = { enabled = false },
            dash = { enabled = false },
            document = { enabled = false },
            heading = { enabled = false },
            html = { enabled = false },
            indent = { enabled = false },
            inline_highlight = { enabled = false },
            latex = { enabled = false },
            link = { enabled = false },
            paragraph = { enabled = false },
            quote = { enabled = false },
            sign = { enabled = false },
            yaml = { enabled = false },
            -- Keep treesitter from hiding **, `, and link URLs.
            -- Tables still pad and draw borders, but center/right alignment needs conceal.
            win_options = { conceallevel = { rendered = 0 } },
            completions = { blink = { enabled = true } },
        },
        keys = {
            { "<leader>mt", "<cmd>RenderMarkdown toggle<cr>", desc = "Markdown Render Toggle" },
        },
    },
    {
        "jmbuhr/otter.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {},
    },
    -- {
    --     "OXY2DEV/markview.nvim",
    --     lazy = false,
    --     dependencies = {
    --         "saghen/blink.cmp",
    --     },
    --     opts = function()
    --         local presets = require('markview.presets')
    --         return {
    --             markdown = {
    --                 -- headings = presets.headings.arrowed,
    --                 -- list_items = {
    --                     -- shift_width = 0,
    --                     -- add_padding = false,
    --                     -- marker_minus = { text = "•" },
    --                     -- marker_plus = { text = "•" },
    --                     -- marker_star = { text = "•" },
    --                 -- },
    --             },
    --         }
    --     end,
    --     keys = {
    --         { "<leader>mh", "<cmd>Markview HybridToggle<cr>", desc = "Markdown Hybrid Toggle" },
    --         { "<leader>mt", "<cmd>Markview Toggle<cr>", desc = "Markdown Render Toggle" },
    --     },
    -- },
    {
        "selimacerbas/mdkite.nvim",
        dependencies = { "selimacerbas/kitehost.nvim" },
        ft = { "markdown" },
        opts = {
            instance_mode = "takeover",
            port = 0,
            open_browser = true,
            debounce_ms = 300,
            mermaid_renderer = "rust",
        },
        keys = {
            { "<leader>mp", "<cmd>MdKite start<cr>", desc = "Markdown Preview" },
        },
    },
}
