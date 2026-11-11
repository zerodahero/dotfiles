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
            },
            diff = {
                gutter_signs = {
                    -- Blank sign on unchanged lines at priority 7. It hides
                    -- gitsigns (priority 6), whose signs compare against the
                    -- index, not the review base, and would mislead here.
                    unchanged_priority = 7,
                },
            },
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
        config = function(_, opts)
            require("review").setup(opts)

            -- review.nvim re-applies readonly, its keymaps, and the first-hunk
            -- jump a fixed 100 ms after a file switch. codediff swaps in the
            -- new buffers only once its async diff render ends, which is often
            -- later. The new pane then keeps a modifiable buffer with no `r`
            -- mapping, and the jump finds no diff. Redo all three once the
            -- render is done. Remove when review.nvim waits for the render.
            vim.api.nvim_create_autocmd("User", {
                group = vim.api.nvim_create_augroup("zerodahero_review_resync", { clear = true }),
                pattern = "CodeDiffFileSelect",
                callback = function(ev)
                    local lifecycle = require("codediff.ui.lifecycle")
                    local tabpage = (ev.data and ev.data.tabpage) or vim.api.nvim_get_current_tabpage()
                    local session = lifecycle.get_session(tabpage)
                    if not session then
                        return
                    end
                    local old_result = session.stored_diff_result

                    local timer = vim.uv.new_timer()
                    local elapsed = 0
                    timer:start(20, 20, vim.schedule_wrap(function()
                        elapsed = elapsed + 20
                        local sess = lifecycle.get_session(tabpage)
                        local result = sess and sess.stored_diff_result
                        local ready = result ~= nil and result ~= old_result
                        if not ready and sess and elapsed < 3000 then
                            return
                        end
                        if timer:is_active() then
                            timer:stop()
                            timer:close()
                        end
                        if not ready then
                            return
                        end

                        require("review.hooks").on_file_changed(tabpage)
                        require("review.keymaps").setup_keymaps(tabpage)

                        local first = result.changes and result.changes[1]
                        if not first then
                            return
                        end
                        local orig_win, mod_win = lifecycle.get_windows(tabpage)
                        if orig_win and vim.api.nvim_win_is_valid(orig_win) then
                            pcall(vim.api.nvim_win_set_cursor, orig_win, { first.original.start_line, 0 })
                        end
                        if mod_win and vim.api.nvim_win_is_valid(mod_win) then
                            pcall(vim.api.nvim_win_set_cursor, mod_win, { first.modified.start_line, 0 })
                            vim.api.nvim_win_call(mod_win, function() vim.cmd("normal! zz") end)
                        end
                    end))
                end,
            })
        end,
    },
}
