return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
    },
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
