-- Configure diagnostics.
---@class vim.diagnostics.Opts
vim.diagnostic.config({
    severity_sort = true,
    signs = true,
    -- virtual_text = {severity = {min = vim.diagnostic.severity.ERROR}, spacing = 8},
    virtual_text = false, -- use lsp-lines for virtual text
    underline = { severity = vim.diagnostic.severity.WARN },
    float = { sorce = "always" },
})
