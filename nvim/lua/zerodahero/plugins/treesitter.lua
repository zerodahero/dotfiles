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
                "query",
                "vim",
                "vimdoc",
            }
            require("nvim-treesitter").install(filetypes)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = filetypes,
                callback = function() vim.treesitter.start() end,
            })
        end,
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "diff",
                "html",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "query",
                "vim",
                "vimdoc",
            },
            auto_install = true,
            highlight = {
                enable = true,
            },
            indent = { enable = true },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Auto-select input or output if in next_object/previous_object
                    keymaps = {
                        ["ib"] = "@block.inner",
                        ["ab"] = "@block.outer",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_previous_start = {
                        ["[["] = "@block.outer",
                    },
                },
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
            mode = "cursor",
            -- separator = "-",
        },
    },
}
