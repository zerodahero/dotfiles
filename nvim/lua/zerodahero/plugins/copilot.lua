return {
    "github/copilot.vim",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        vim.keymap.set(
            "i",
            "<C-i>",
            "copilot#Accept('')",
            { expr = true, noremap = true, silent = true, replace_keycodes = false, script = true }
        )
        vim.keymap.set("n", "<leader>ai", function()
            if vim.g.copilot_enabled == 1 then
                vim.cmd("Copilot disable")
                print("Disabled Copilot")
            else
                vim.cmd("Copilot enable")
                print("Enabled Copilot")
            end
        end)

        vim.g.copilot_no_tab_map = true
        vim.g.copilot_enabled = 1
    end,
}
