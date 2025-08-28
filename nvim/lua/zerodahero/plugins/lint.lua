return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

        -- lint.linters_by_ft = {javascript = {'eslint'}, typescript = {'eslint'}}
        lint.linters_by_ft = {
            dockerfile = { "hadolint" },
            sql = { "sqlfluff" },
            python = { "ruff" },
            -- yaml = { "kube-linter" },
        }

        -- Leave the dialect up to the sqlfluff config
        lint.linters.sqlfluff.args = { "lint", "--format=json" }

        lint.linters.cspell = require("lint.util").wrap(lint.linters.cspell, function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT
            return diagnostic
        end)

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                if vim.bo.modifiable then
                    lint.try_lint()
                    lint.try_lint("cspell")
                end
            end,
        })

        vim.keymap.set("n", "<leader>ml", function()
            lint.try_lint()
            lint.try_lint("cspell")
        end, { desc = "Lint current buffer" })

        -- Show linters for the current buffer's file type
        vim.api.nvim_create_user_command("LintInfo", function()
            local filetype = vim.bo.filetype
            local linters = lint.linters_by_ft[filetype]

            if linters then
                print("Linters for " .. filetype .. ": " .. table.concat(linters, ", "))
            else
                print("No linters configured for filetype: " .. filetype)
            end
        end, {})
    end,
}
