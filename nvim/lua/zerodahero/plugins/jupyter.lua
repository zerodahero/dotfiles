return {
    -- Cell-aware editing for jupytext py:percent files (# %% markers).
    -- Uses molten as the execution backend and wires into the already-installed mini.nvim.
    {
        "GCBallesteros/NotebookNavigator.nvim",
        dependencies = {
            "echasnovski/mini.nvim",
            "benlubas/molten-nvim",
        },
        ft = { "python", "markdown" },
        keys = {
            { "]x", function() require("notebook-navigator").move_cell("d") end, desc = "Next cell" },
            { "[x", function() require("notebook-navigator").move_cell("u") end, desc = "Prev cell" },
            { "<leader>jC", function() require("notebook-navigator").run_cell() end, desc = "Molten: run cell" },
            {
                "<leader>jc",
                function() require("notebook-navigator").run_and_move() end,
                desc = "Molten: run cell & advance",
            },
        },
        config = function()
            local nn = require("notebook-navigator")
            nn.setup({ repl_provider = "molten" })

            -- Cell text object: ih / ah (inside / around cell)
            require("mini.ai").setup({
                custom_textobjects = { h = nn.miniai_spec },
            })
            -- Highlight the # %% cell markers as separators
            require("mini.hipatterns").setup({
                highlighters = { cells = nn.minihipatterns_spec },
            })
        end,
    },

    {
        "benlubas/molten-nvim",
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            -- Dedicated venv for the python3 remote-plugin host (has pynvim + jupyter_client).
            -- Isolated from mise's main env so it isn't wiped by pip cleanups.
            vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python")
            -- jupyter_client writes kernel connection files here but won't create the
            -- dir itself; without this MoltenInit fails with ENOENT on the runtime dir.
            local jupyter_runtime = vim.fn.has("mac") == 1 and vim.fn.expand("~/Library/Jupyter/runtime")
                or vim.fn.expand("~/.local/share/jupyter/runtime")
            vim.fn.mkdir(jupyter_runtime, "p")
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20
            vim.g.molten_auto_open_output = false
            -- Nicer for jupytext py:percent workflows: show text output as virtual
            -- text under the evaluated code, wrapped. Images still open via ,jo.
            vim.g.molten_virt_text_output = true
            vim.g.molten_wrap_output = true
            -- Recommended when using image.nvim so images don't overlap by one line.
            vim.g.molten_virt_lines_off_by_1 = true
        end,
        config = function()
            local map = vim.keymap.set
            local opts = function(desc) return { silent = true, desc = "Molten: " .. desc } end
            map("n", "<leader>ji", ":MoltenInit<CR>", opts("init kernel"))
            map("n", "<leader>je", ":MoltenEvaluateOperator<CR>", opts("evaluate operator"))
            map("n", "<leader>jl", ":MoltenEvaluateLine<CR>", opts("evaluate line"))
            map("n", "<leader>jr", ":MoltenReevaluateCell<CR>", opts("re-evaluate cell"))
            map("n", "<leader>jd", ":MoltenDelete<CR>", opts("delete cell"))
            map("n", "<leader>jo", ":noautocmd MoltenEnterOutput<CR>", opts("enter/show output"))
            map("n", "<leader>jh", ":MoltenHideOutput<CR>", opts("hide output"))
            map("n", "<leader>jn", ":MoltenNext<CR>", opts("next cell"))
            map("n", "<leader>jp", ":MoltenPrev<CR>", opts("prev cell"))
            map("n", "<leader>jx", ":MoltenInterrupt<CR>", opts("interrupt kernel"))
            map("n", "<leader>jR", ":MoltenRestart<CR>", opts("restart kernel"))
            map("v", "<leader>je", ":<C-u>MoltenEvaluateVisual<CR>gv", opts("evaluate selection"))
            map("n", "<leader>jy", ":MoltenYankOutput!<CR>", opts("evaluate selection"))
        end,
    },
    {
        "3rd/image.nvim",
        opts = {
            backend = "kitty",
            max_width = 100,
            max_height = 12,
            max_height_window_percentage = math.huge,
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true,
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        },
    },
}
