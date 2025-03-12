return {
    "EdenEast/nightfox.nvim",
    name = "nightfox",
    lazy = false,
    priority = 1000,
    config = function()
        local nightfox = require("nightfox")

        nightfox.setup({
            options = {
                transparent = false,
                dim_inactive = true,
                inverse = { visual = true, match_paren = false, search = false },
                styles = {
                    types = "italic",
                },
            },
            palettes = {
                carbonfox = {
                    sel0 = "#4d4d4d",
                    sel1 = "#6a6a6c",
                    -- original:
                    -- sel0 = "#2a2a2a",
                    -- sel1 = "#525253",
                },
            },
        })
        nightfox.compile()

        vim.cmd("colorscheme carbonfox")
    end,
}
