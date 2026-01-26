return {
    "mbbill/undotree",
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },
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
        "gregorias/coerce.nvim",
        tag = "v4.1.0",
        config = true,
    },

    -- nvim lua config
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },

    -- Debugging
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            -- UI
            { "rcarriga/nvim-dap-ui" },
            { "theHamsta/nvim-dap-virtual-text" },

            -- Adapters
            -- This has all sorts of issues
            -- { "mxsdev/nvim-dap-vscode-js" },
            -- {
            --     "microsoft/vscode-js-debug",
            --     lazy = true,
            --     build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out && git restore .",
            -- },
        },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },

    {
        "rmagatti/alternate-toggler",
        opts = {},
        keys = {
            { "<leader>b", "<cmd>lua require('alternate-toggler').toggleAlternate()<cr>", desc = "Toggle Alternate" },
        },
    },
    {
        "windwp/nvim-autopairs",
        opts = {},
    },

    -- Configured in prose.lua
    "preservim/vim-pencil",
    "preservim/vim-wordy",
    "rudism/telescope-dict.nvim",
    "dbmrq/vim-ditto",
    -- 'preservim/vim-lexical'

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            {
                "nvim-tree/nvim-web-devicons",
                opts = {
                    override_by_extension = {
                        ["bats"] = {
                            icon = "󰭟",
                            color = "#CBCB41",
                            cterm_color = "185",
                            name = "bats",
                        },
                    },
                },
            },
        },
    },

    -- Closes unedited buffers above threshold
    {
        "axkirillov/hbac.nvim",
        opts = {
            autoclose = true, -- set autoclose to false if you want to close manually
            threshold = 8, -- hbac will start closing unedited buffers once that number is reached
            close_command = function(bufnr) require("snacks").bufdelete({ buf = bufnr }) end,
        },
    },
    {
        "Aasim-A/scrollEOF.nvim",
        event = { "CursorMoved", "WinScrolled" },
        opts = {},
    },

    {
        "HiPhish/rainbow-delimiters.nvim",
    },

    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            -- 'antoinemadec/FixCursorHold.nvim', -- supposedly not needed anymore?
            "olimorris/neotest-phpunit",
            "Issafalcon/neotest-dotnet",
            "ChristianChiarulli/neovim-codicons",
            "nvim-neotest/neotest-jest",
            "adrigzr/neotest-mocha",
            "nvim-neotest/neotest-python",
        },
    },

    -- {
    --     "glacambre/firenvim",
    --     build = function() vim.fn["firenvim#install"](0) end,
    -- },

    { "HiPhish/jinja.vim" },
    {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        -- init = function()
        --     -- VimTeX configuration goes here, e.g.
        --     vim.g.vimtex_view_method = "zathura"
        -- end,
    },

    -- DOcument GEnterator (docblocks, etc)
    {
        "kkoomen/vim-doge",
        build = ":call doge#install()",
        init = function() vim.g.doge_mapping = "<leader>doc" end,
    },

    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {},
    },

    { "kevinhwang91/nvim-bqf", ft = "qf" },
}
