return {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
        require("mini.cursorword").setup()
        require("mini.trailspace").setup()
        require("mini.splitjoin").setup()
    end,
}
