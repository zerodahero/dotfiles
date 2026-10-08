return {
    {
        "akinsho/git-conflict.nvim",
        version = "*",
        config = true,
    },

    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        opts = {
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")
                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end
                map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end)
                map("n", "<leader>hd", gitsigns.diffthis)
                map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
                map("n", "<leader>tw", gitsigns.toggle_word_diff)
            end,
        },
    },

    {
        "sindrets/diffview.nvim",
    },

    {
        "esmuellert/codediff.nvim",
        cmd = "CodeDiff",
        keys = {
            { "<leader>gd", "<cmd>CodeDiff<cr>", desc = "CodeDiff: working tree" },
        },
        opts = {
            explorer = {
                view_mode = "tree"
            }
        }
    },

    {
        "georgeguimaraes/review.nvim",
        version = "*",
        dependencies = {
            "esmuellert/codediff.nvim",
            "MunifTanjim/nui.nvim",
        },
        -- VeryLazy, not cmd: notes left outside a review only render once the
        -- plugin has loaded.
        event = "VeryLazy",
        keys = {
            { "<leader>gr", "<cmd>Review<cr>", desc = "Review: working tree" },
            { "<leader>gc", "<cmd>Review commits<cr>", desc = "Review: pick commits" },
            {
                "<leader>gb",
                function()
                    -- With the checked-out branch as target, review.nvim diffs
                    -- the merge base against the working tree. Detached HEAD
                    -- has no branch name, so fall back to the picker.
                    local branch = vim.trim(vim.fn.system({ "git", "branch", "--show-current" }))
                    require("review").open_branch(branch ~= "" and branch or nil)
                end,
                desc = "Review: current branch vs base",
            },
            { "<leader>gB", "<cmd>Review branch<cr>", desc = "Review: pick branch vs base" },
            -- `:` on purpose: in visual mode it becomes :'<,'>Review note.
            { "<leader>gn", ":Review note<cr>", mode = { "n", "v" }, desc = "Review: note here" },
            { "<leader>ge", "<cmd>Review edit<cr>", desc = "Review: edit comment" },
            { "<leader>gx", "<cmd>Review delete<cr>", desc = "Review: delete comment" },
            { "<leader>gy", "<cmd>Review export<cr>", desc = "Review: export to clipboard" },
        },
        -- branch.base stays nil: it then uses the LOCAL branch that origin/HEAD
        -- names (e.g. main, not origin/main), else main or master.
        opts = {},
    },
}
