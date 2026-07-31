return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        notifier = { enabled = true },
    },
    -- The notifier overrides vim.notify, so notifications show as toasts instead of
    -- landing in :messages. :Messages opens the snacks notification history to read them.
    init = function()
        vim.api.nvim_create_user_command("Messages", function()
            Snacks.notifier.show_history()
        end, { desc = "Show snacks notification history" })
    end,
    keys = {
        { "<leader>qq", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
        {
            "<leader>wq",
            function()
                vim.cmd("update")
                Snacks.bufdelete()
            end,
            desc = "Delete Buffer",
        },
        { "<leader>qa", function() Snacks.bufdelete.all() end, desc = "Delete Buffer" },
        { "<leader>q1", function() Snacks.bufdelete.other() end, desc = "Delete Buffer" },
    },
}
