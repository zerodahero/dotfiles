return {
    "michaelb/sniprun",
    branch = "master",

    build = "sh install.sh",
    opts = {
        display = { "TerminalWithCode" },
        display_options = {
            terminal_scrollback = vim.o.scrollback, -- change terminal display scrollback lines
            terminal_line_number = false, -- whether show line number in terminal window
            terminal_signcolumn = false, -- whether show signcolumn in terminal window
            terminal_position = "vertical", --# or "horizontal", to open as horizontal split instead of vertical split
        },
        interpreter_options = {
            TypeScript_original = {
                interpreter = "node",
            },
            Generic = {
                nim = {
                    supported_filetypes = { "nim" },
                    extension = ".nims",
                    exe_name = "sniprun_nim",
                    compiler = "",
                    interpreter = "nim",
                    boilerplate_pre = "",
                    boilerplate_post = "",
                },
            },
        },
    },

    keys = {
        { "<leader>rr", "<cmd>SnipRun<cr>", mode = { "n", "v" }, desc = "Run Snippet" },
        { "<leader>rR", "<cmd>SnipReset<cr>", desc = "Reset Snippet" },
    },
}
