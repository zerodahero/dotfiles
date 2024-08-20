-- require("neodev").setup({ library = { plugins = { "nvim-dap-ui" }, types = true } })

-- Configure diagnostics.
vim.diagnostic.config({
    severity_sort = true,
    signs = true,
    -- virtual_text = {severity = {min = vim.diagnostic.severity.ERROR}, spacing = 8},
    virtual_text = false,
    underline = { severity = vim.diagnostic.severity.WARN },
})

-- require("fidget").setup()

-- require("lsp-toggle").setup()

-- require("outline").setup()
--
-- vim.keymap.set("n", "<leader>vyo", ":Outline<CR>", {})

-- require("nvim-navic").setup({ lsp = { auto_attach = true, preference = { "volar" } }, highlight = true })
