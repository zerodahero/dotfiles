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
                "hurl",
                "javascript",
                "kdl",
                "korin",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "nim",
                "python",
                "query",
                "svelte",
                "toml",
                "typescript",
                "vim",
                "vimdoc",
                "zsh",
            }

            -- Used by after/queries/toml/injections.scm to limit `run` script
            -- highlighting to mise config files.
            -- See https://mise.jdx.dev/mise-cookbook/neovim.html
            vim.treesitter.query.add_predicate("is-mise?", function(_, _, bufnr, _)
                local filepath = vim.fs.normalize(vim.api.nvim_buf_get_name(tonumber(bufnr) or 0))
                local filename = vim.fn.fnamemodify(filepath, ":t")
                return filename:match("^%.?mise.*%.toml$") ~= nil
                    or filepath:match("/%.?mise/config%.toml$") ~= nil
                    or filepath:match("/%.?mise/config%.local%.toml$") ~= nil
                    or filepath:match("/%.?mise/config%.[^/]+%.toml$") ~= nil
                    or filepath:match("/%.config/mise/mise%.toml$") ~= nil
                    or filepath:match("/%.config/mise/mise%.local%.toml$") ~= nil
                    or filepath:match("/%.?mise/conf%.d/[^/]+%.toml$") ~= nil
            end, { force = true, all = false })

            require("nvim-treesitter").install(filetypes)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = filetypes,
                callback = function() vim.treesitter.start() end,
            })

            vim.filetype.add({ extension = { korin = "korin" } })

            vim.api.nvim_create_autocmd("User", {
                pattern = "TSUpdate",
                callback = function()
                    require("nvim-treesitter.parsers").korin = {
                        install_info = {
                            url = "https://github.com/zerodahero/tree-sitter-korin",
                            queries = "queries",
                        },
                    }
                end,
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
