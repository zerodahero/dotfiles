return {
    "folke/trouble.nvim",
    opts = {
        ---@class trouble.Mode: trouble.Config,trouble.Section.spec
        ---@field desc? string
        ---@field sections? string[]

        ---@class trouble.Config
        ---@field mode? string
        ---@field config? fun(opts:trouble.Config)
        ---@field formatters? table<string,trouble.Formatter> custom formatters
        ---@field filters? table<string, trouble.FilterFn> custom filters
        ---@field sorters? table<string, trouble.SorterFn> custom sorters

        ---@type table<string, trouble.Mode>
        modes = {
            nospell_diagnostics = {
                mode = "diagnostics",
                -- filter = function(items)
                --     return vim.tbl_filter(function(item)
                --         return item.item.source ~= "cspell"
                --     end, items)
                -- end
                filter = {
                    ["not"] = { source = "cspell" },
                },
            },
        },
    }, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble nospell_diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xd",
            "<cmd>Trouble nospell_diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        -- {
        --   "<leader>cs",
        --   "<cmd>Trouble symbols toggle focus=false<cr>",
        --   desc = "Symbols (Trouble)",
        -- },
        -- {
        --   "<leader>cl",
        --   "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        --   desc = "LSP Definitions / references / ... (Trouble)",
        -- },
        -- {
        --     "<leader>xL",
        --     "<cmd>Trouble loclist toggle<cr>",
        --     desc = "Location List (Trouble)",
        -- },
        {
            "<leader>xq",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },
}
-- TODO:
-- vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
-- vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
