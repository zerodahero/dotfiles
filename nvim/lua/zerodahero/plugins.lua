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

    -- lsp status updates
    { "j-hui/fidget.nvim", opts = {} },

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
                build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
            },
        },
    },

    {
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        opts = {
            bind = true,
        },
    },

    {
        "SmiteshP/nvim-navic",
        opts = {
            lsp = { auto_attach = true, preference = { "volar" } },
            highlight = true,
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
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", opt = true } },
    { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },

    "simeji/winresizer",
    {
        "kwkarlwang/bufresize.nvim",
        config = function()
            require("bufresize").setup()
        end,
    },

    {
        "glacambre/firenvim",
        build = function()
            vim.fn["firenvim#install"](0)
        end,
    },

    -- Little floating window with file name
    "b0o/incline.nvim",

    -- Buffer closing without closing windows
    "moll/vim-bbye",
    "arithran/vim-delete-hidden-buffers",

    -- Closes unedited buffers above threshold
    {
        "axkirillov/hbac.nvim",
        opts = {
            threshold = 9,
        },
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
    { "folke/twilight.nvim", opts = {} },
    { "folke/zen-mode.nvim", opts = {} },

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
        opts = {
            code = {
                border = "thick",
            },
        },
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
