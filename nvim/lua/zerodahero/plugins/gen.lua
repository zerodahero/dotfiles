return {
    "David-Kunz/gen.nvim",
    opts = {
        model = "mistral", -- The default model to use.
    },
    cmd = "Gen",
    keys = {
        { "<leader><leader>g", "<cmd>Gen<cr>", mode = { "n", "v" }, desc = "Gen AI" },
    },
}
