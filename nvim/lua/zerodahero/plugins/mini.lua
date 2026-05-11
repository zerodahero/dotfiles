return {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
        require("mini.align").setup()
        require("mini.cursorword").setup()
        require("mini.trailspace").setup()
        require("mini.splitjoin").setup()
        local map = require("mini.map")
        map.setup({
            symbols = {
                encode = map.gen_encode_symbols.shade(),
            },
            integrations = {
                map.gen_integration.builtin_search(),
                map.gen_integration.diagnostic(),
                map.gen_integration.gitsigns(),
            },
            window = {
                show_integration_count = false,
            }
        })
        vim.keymap.set('n', '<Leader>mm', map.toggle)

    end,
}
