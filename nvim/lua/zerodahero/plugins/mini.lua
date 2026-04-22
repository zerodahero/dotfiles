return {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
        require("mini.align").setup()
        require("mini.cursorword").setup()
        require("mini.trailspace").setup()
        require("mini.splitjoin").setup()
        require("mini.notify").setup({
            lsp_progress = {
                enable = false,
            },
            window = {
                config = function()
                    local has_statusline = vim.o.laststatus > 0
                    local pad = has_statusline and 1 or 0
                    return { anchor = "SE", col = vim.o.columns, row = vim.o.lines - pad }
                end,
            },
        })
        vim.api.nvim_create_user_command("Messages", function() MiniNotify.show_history() end, {})
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
