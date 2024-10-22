return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-telescope/telescope-ui-select.nvim" } },
    },

    "nvim-telescope/telescope-dap.nvim",
    "gbrlsnchs/telescope-lsp-handlers.nvim",
    "keyvchan/telescope-find-pickers.nvim",
    { "benfowler/telescope-luasnip.nvim", module = "telescope._extensions.luasnip" },
}
