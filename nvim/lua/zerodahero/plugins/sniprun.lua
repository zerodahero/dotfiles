return {
    "michaelb/sniprun",
    branch = "master",

    build = "sh ./install.sh",
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
        { "<leader>rr", "<Plug>SnipRun", mode = { "n" }, desc = "Run Snippet" },
        { "<leader>rr", "<Plug>SnipRun", mode = { "v" }, desc = "Run Snippet" },
        { "<leader>rR", "<Plug>SnipReset", desc = "Reset SnipRun" },
        { "<leader>rc", "<Plug>SnipClose", desc = "Close SnipRun" },
        {
            "<leader>ry",
            function()
                -- 1. Run Sniprun on the visual selection
                vim.cmd("SnipRun")

                -- 2. Brief delay to let Sniprun process, then yank the last output
                -- Note: Sniprun stores the last output in a global variable
                local output = _G.SnipRun_last_output or ""
                if output ~= "" then
                    vim.fn.setreg("+", output)
                    print("Code executed and output copied to clipboard!")
                end
            end,
            desc = "Run Snippet and copy output",
        },
    },
}
