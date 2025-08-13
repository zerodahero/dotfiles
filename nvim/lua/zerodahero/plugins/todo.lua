return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        keywords = {
            FUTURE = { icon = "󰈑 ", color = "info" },
            REMOVEME = { icon = "󰅙 ", color = "error", alt = { "REMOVE", "DELETEME", "DELETE" } },
        },
    },
}
