return {
    "David-Kunz/gen.nvim",
    opts = {
        -- model = "qwen2.5-coder:14b", -- The default model to use.
    },
    cmd = "Gen",
    keys = {
        { "<leader><leader>g", ":Gen<CR>", mode = { "n", "v" }, desc = "Gen AI" },
    },
}
