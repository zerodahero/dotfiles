return {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
        require("mini.cursorword").setup()
        require("mini.trailspace").setup()
        require("mini.splitjoin").setup()
        require("mini.notify").setup({
            lsp_progress = {
                enable = false
            }
        })
    end,
}
