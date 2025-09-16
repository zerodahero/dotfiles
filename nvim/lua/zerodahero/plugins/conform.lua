return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>mf",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" }, function(err)
                    if not err then
                        local mode = vim.api.nvim_get_mode().mode
                        if vim.startswith(string.lower(mode), "v") then
                            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
                        end
                    end
                end)
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    -- Everything in opts will be passed to setup()
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            bash = { "shellharden" },
            sh = { "shellharden" },
            -- cs = { "csharpier" },
            dart = { "dart_format" },
            go = { "gofmt" },
            html = { "prettierd" },
            hurl = { "hurlfmt" },
            javascript = { "biome", "biome-organize-imports", "eslint_d", "prettierd" },
            json = { "fixjson" },
            lua = { "stylua" },
            markdown = { "mdformat", "injected" },
            nim = { "nimpretty" },
            php = { "php_cs_fixer" },
            rust = { "rustfmt" },
            python = { "ruff", "ruff_format", "ruff_organize_imports" },
            scala = { "scalafmt" },
            sql = { "sqruff", "sqlfluff", "pg_format" },
            typescript = { "biome", "biome-organize-imports", "eslint_d", "prettierd" },
            vue = { "biome", "eslint_d" },
            yaml = { "yamlfmt" },
            toml = { "taplo" },
            ["*"] = { "trim_newlines", "trim_whitespace" },
        },
        -- log_level = vim.log.levels.DEBUG,
        -- Set up format-on-save
        -- format_on_save = { timeout_ms = 500, lsp_fallback = true },
        formatters = {
            biome = {
                condition = function()
                    return (vim.loop.fs_realpath("biome.json") ~= nil or vim.loop.fs_realpath("biome.jsonc") ~= nil)
                        -- no config, so use biome by default
                        or (
                            vim.loop.fs_realpath("biome.json") == nil
                            and vim.loop.fs_realpath("biome.jsonc") == nil
                            and vim.loop.fs_realpath(".prettierrc.js") == nil
                            and vim.loop.fs_realpath(".prettierrc.mjs") == nil
                            and vim.loop.fs_realpath(".prettierrc") == nil
                            and vim.loop.fs_realpath(".eslint.config.js") == nil
                            and vim.loop.fs_realpath(".eslint.config.mjs") == nil
                            and vim.loop.fs_realpath(".eslintrc") == nil
                            and vim.loop.fs_realpath(".eslintrc.json") == nil
                            and vim.loop.fs_realpath(".eslintrc.yml") == nil
                        )
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
            injected = {
                options = {
                    ignore_errors = true,
                },
            },
            sqruff = {
                condition = function()
                    return vim.loop.fs_realpath(".sqruff") ~= nil
                end,
            },
            sqlfluff = {
                condition = function()
                    return vim.loop.fs_realpath(".sqlfluff") ~= nil
                end,
            },
        },
    },
    init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
