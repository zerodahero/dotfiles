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
        opts = {},
    },
    {
        "gregorias/coerce.nvim",
        tag = "v4.1.0",
        config = true,
    },

    -- linter
    { "mfussenegger/nvim-lint" },

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
            { "mxsdev/nvim-dap-vscode-js" },
            {
                "microsoft/vscode-js-debug",
                lazy = true,
                build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out && git restore .",
            },
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
        config = function()
            vim.keymap.set("n", "<leader>b", function()
                require("alternate-toggler").toggleAlternate()
            end)
        end,
        event = { "BufReadPost" }, -- lazy load after reading a buffer
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
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
            "nvim-tree/nvim-web-devicons", -- optional, for file icons
        },
    },

    -- Closes unedited buffers above threshold
    {
        "axkirillov/hbac.nvim",
        opts = {
            autoclose = true, -- set autoclose to false if you want to close manually
            threshold = 9, -- hbac will start closing unedited buffers once that number is reached
            close_command = function(bufnr)
                vim.cmd("Bdelete " .. bufnr)
            end,
        },
    },
    {
        "Aasim-A/scrollEOF.nvim",
        event = { "CursorMoved", "WinScrolled" },
        opts = {},
    },

    "HiPhish/rainbow-delimiters.nvim",
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
        },
    },

    {
        "glacambre/firenvim",
        build = function()
            vim.fn["firenvim#install"](0)
        end,
    },

    -- DOcument GEnterator (docblocks, etc)
    { "kkoomen/vim-doge", build = ":call doge#install()" },

    "hedyhli/outline.nvim",
    "terrastruct/d2-vim",

    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        ft = { "markdown", "codecompanion" },
        opts = {
            code = {
                border = "thick",
            },
            checkbox = {
                -- bullet = true,
            },
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && npm install && git restore .",
        keys = {
            { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
        },
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
        },
    },
    { "kevinhwang91/nvim-bqf", ft = "qf" },
}
