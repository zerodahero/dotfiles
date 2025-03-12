return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>mf",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    -- Everything in opts will be passed to setup()
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            lua = { "stylua" },
            javascript = { "biome", "biome-organize-imports", "eslint_d", "prettierd" },
            typescript = { "biome", "biome-organize-imports", "eslint_d", "prettierd" },
            vue = { "biome", "eslint_d" },
            cs = { "csharpier" },
            dart = { "dart_format" },
            go = { "gofmt" },
            json = { "fixjson" },
            php = { "php_cs_fixer" },
            rust = { "rustfmt" },
            markdown = { "mdformat" },
            yaml = { "yamlfmt" },
            nim = { "nimpretty" },
            hurl = { "hurlfmt" },
            bash = { "shfmt" },
            ["*"] = { "trim_newlines", "trim_whitespace" },
        },
        log_level = vim.log.levels.DEBUG,
        -- Set up format-on-save
        -- format_on_save = { timeout_ms = 500, lsp_fallback = true },
        formatters = {
            biome = {
                condition = function()
                    return vim.loop.fs_realpath("biome.json") ~= nil or vim.loop.fs_realpath("biome.jsonc") ~= nil
                end,
            },
            ["biome-organize-imports"] = {
                condition = function()
                    return vim.loop.fs_realpath("biome.json") ~= nil or vim.loop.fs_realpath("biome.jsonc") ~= nil
                end,
            },
            prettierd = {
                condition = function()
                    return vim.loop.fs_realpath(".prettierrc.js") ~= nil
                        or vim.loop.fs_realpath(".prettierrc.mjs") ~= nil
                        or vim.loop.fs_realpath(".prettierrc") ~= nil
                end,
            },
            eslint_d = {
                condition = function()
                    return vim.loop.fs_realpath(".eslint.config.js") ~= nil
                        or vim.loop.fs_realpath(".eslint.config.mjs") ~= nil
                        or vim.loop.fs_realpath(".eslintrc") ~= nil
                        or vim.loop.fs_realpath(".eslintrc.json") ~= nil
                        or vim.loop.fs_realpath(".eslintrc.yml") ~= nil
                end,
            },
        },
    },
    init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
