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
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            vue = { "eslint_d" },
            json = { "fixjson" },
            php = { "php_cs_fixer" },
            rust = { "rustfmt" },
            markdown = { "mdformat" },
            yaml = { "yamlfmt" },
            ["*"] = { "trim_newlines", "trim_whitespace" },
        },
        log_level = vim.log.levels.DEBUG,
        -- Set up format-on-save
        -- format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
    init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
