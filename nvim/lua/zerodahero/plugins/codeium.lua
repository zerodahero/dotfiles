return {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    cond = vim.env.COPILOT_ENABLED ~= 0,
    config = function()
        vim.g.codeium_enabled = 1
        vim.g.codeium_disable_bindings = 0
        vim.g.codeium_no_map_tab = 1

        vim.keymap.set("i", "<C-S-Y>", function()
            return vim.fn["codeium#Accept"]()
        end, { expr = true, noremap = true, silent = true, replace_keycodes = false, script = true })

        vim.keymap.set("n", "<leader>ai", function()
            if vim.g.codeium_enabled == 1 then
                vim.cmd("CodeiumDisable")
                print("Disabled Codeium")
            else
                vim.cmd("CodeiumEnable")
                print("Enabled Codeium")
            end
        end)

        -- Defaults
        -- vim.keymap.set("i", "<M-]>", function()
        --     return vim.fn["codeium#CycleCompletions"](1)
        -- end, { expr = true, silent = true })
        -- vim.keymap.set("i", "<M-[>", function()
        --     return vim.fn["codeium#CycleCompletions"](-1)
        -- end, { expr = true, silent = true })
        -- vim.keymap.set("i", "<C-]>", function()
        --     return vim.fn["codeium#Clear"]()
        -- end, { expr = true, silent = true })
    end,
}
