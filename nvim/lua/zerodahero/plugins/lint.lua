return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

        -- lint.linters_by_ft = {javascript = {'eslint'}, typescript = {'eslint'}}
        lint.linters_by_ft = {
            -- yaml = { "kube-linter" },
        }

        lint.linters.cspell = require("lint.util").wrap(lint.linters.cspell, function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT
            return diagnostic
        end)

        -- lint.linters.kubelint = {
        --     cmd = "kube-linter",
        --     stdin = false,
        --     args = { "lint", "--format", "sarif"},
        --     stream = "stdout",
        --     ignore_errors = false,
        --     ignore_exitcode = true,
        --     parser = require("lint.parser").for_sarif({}),
        -- }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
                lint.try_lint("cspell")
            end,
        })

        vim.keymap.set("n", "<leader>ml", function()
            lint.try_lint()
            lint.try_lint("cspell")
        end, { desc = "Lint current buffer" })
    end,
}
