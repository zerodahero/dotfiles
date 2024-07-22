return {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    cond = vim.env.COPILOT_ENABLED ~= 0,
    config = function()
        vim.g.codeium_enabled = true
        vim.g.codeium_disable_bindings = 0
        vim.g.codeium_no_map_tab = 1

        vim.keymap.set("i", "<C-S-Y>", function()
            return vim.fn["codeium#Accept"]()
        end, { expr = true, noremap = true, silent = true, replace_keycodes = false, script = true })

        vim.keymap.set("n", "<leader>ai", ":CodeiumToggle<CR>")
    end,
}
