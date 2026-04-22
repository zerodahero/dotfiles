return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-context",
        },
        config = function()
            local filetypes = {
                "bash",
                "c",
                "cooklang",
                "diff",
                "html",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "typescript",
                "vim",
                "vimdoc",
            }
            require("nvim-treesitter").install(filetypes)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = filetypes,
                callback = function() vim.treesitter.start() end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
            local select = require("nvim-treesitter-textobjects.select")

            require("nvim-treesitter-textobjects").setup({
                select = { lookahead = true },
                move = { set_jumps = true },
            })

            vim.keymap.set({ "x", "o" }, "ib", function() select.select_textobject("@block.inner") end)
            vim.keymap.set({ "x", "o" }, "ab", function() select.select_textobject("@block.outer") end)

        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
            mode = "cursor",
            -- separator = "-",
        },
    },
}
