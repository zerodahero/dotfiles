local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
    pickers = {
        find_files = {
            hidden = true,
            no_ignore = false,
            path_display = { "truncate" },
        },
        oldfiles = { sort_mru = true, ignore_current_buffer = true, only_cwd = true },
        live_grep = {
            additional_args = {
                "-i",
            },
        },
    },
    extensions = {
        -- repo = { list = { search_dirs = { "~/projects" } } }
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({ width = 0.8 }),
        },
    },
    defaults = {
        layout_strategy = "center",
        sorting_strategy = "ascending",
        selection_strategy = "closest",
        scroll_strategy = "limit",
        mappings = { i = { ["<esc>"] = require("telescope.actions").close } },
    },
})

telescope.load_extension("fzf")
telescope.load_extension("luasnip")
telescope.load_extension("ui-select")
telescope.load_extension("lsp_handlers")
telescope.load_extension("dap")

-- vim.keymap.set('n', '<leader>ft', function()
--     vim.fn.system('git rev-parse --is-inside-work-tree')
--     if vim.v.shell_error == 0 then
--         builtin.git_files()
--     else
--         builtin.find_files()
--     end
-- end, {})
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fa", function()
    builtin.find_files({ no_ignore = true })
end, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fj", builtin.jumplist, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fc", builtin.commands, {})
vim.keymap.set("n", "<leader>fm", builtin.marks, {})
vim.keymap.set("n", "<leader>fr", builtin.resume, {})
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope luasnip<cr>", { silent = true })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
-- Attempts to find the matching test or file
vim.keymap.set("n", "<leader>ft", function()
    local filetype = vim.bo.filetype
    local filename = vim.fn.expand("%:t:r")

    -- Define test patterns for different filetypes
    local test_patterns = {
        typescript = { pattern = ".test", location = "suffix" },
        javascript = { pattern = ".test", location = "suffix" },
        scala = { pattern = "Suite", location = "suffix" },
        go = { pattern = "_test", location = "suffix" },
        bash = { pattern = ".bats", location = "suffix" },
        sh = { pattern = ".bats", location = "suffix" },
        python = { pattern = "test_", location = "prefix" },
    }

    local pattern_data = test_patterns[filetype]

    if pattern_data then
        local pattern = pattern_data.pattern
        local location = pattern_data.location

        if location == "suffix" and filename:match(pattern .. "$") then
            -- If the file has the test suffix, search for the non-test file
            builtin.find_files({ default_text = filename:gsub(pattern .. "$", "") })
        elseif location == "prefix" and filename:match("^" .. pattern) then
            -- If the file has the test prefix, search for the non-test file
            builtin.find_files({ default_text = filename:gsub("^" .. pattern, "") })
        else
            -- Otherwise, search for the test file
            local new_filename = (location == "prefix" and pattern .. filename) or (filename .. pattern)
            builtin.find_files({ default_text = new_filename })
        end
    else
        -- Fallback for unrecognized filetypes
        builtin.find_files({ default_text = filename })
    end
end, {})

vim.keymap.set("n", "<leader>ss", builtin.spell_suggest, {})
vim.keymap.set("n", "<leader>fp", telescope.extensions.find_pickers.find_pickers)
vim.keymap.set("n", "<leader>fn", "<cmd>TodoTelescope<cr>", { silent = true })
vim.keymap.set("n", "<leader>fd", telescope.extensions.dict.synonyms)
vim.keymap.set("n", "<leader>fY", builtin.lsp_workspace_symbols, {})
vim.keymap.set("n", "<leader>fy", builtin.lsp_document_symbols, {})
