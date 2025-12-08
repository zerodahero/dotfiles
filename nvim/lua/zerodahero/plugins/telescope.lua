return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-telescope/telescope-ui-select.nvim" } },
    },

    "nvim-telescope/telescope-dap.nvim",
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install",
    },
    "gbrlsnchs/telescope-lsp-handlers.nvim",
    "keyvchan/telescope-find-pickers.nvim",
    { "benfowler/telescope-luasnip.nvim", module = "telescope._extensions.luasnip" },
}
