return {
    "chpeters/annotator.nvim",
    opts = {
        storage = "memory",
        hooks = {
            export = function(ctx)
                local dir = vim.fn.getcwd() .. "/.claude/plan"
                vim.fn.mkdir(dir, "p")
                vim.fn.writefile(vim.split(ctx.markdown, "\n"), dir .. "/feedback.md")
                ctx.clear_exported()
                ctx.notify("feedback.md written", "info")
            end,
        },
    },
}
