return {
    "mbbill/undotree",
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },
    {
        "gregorias/coerce.nvim",
        tag = "v5.0.0",
        event = "VeryLazy",
        opts = {
            default_mode_keymap_prefixes = {
                -- normal_mode keeps the default `cr`
                visual_mode = "<leader>cr",
            },
            default_mode_mask = {
                motion_mode = false,
            },
        },
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

    -- Soft-wrap + visual-line nav for prose filetypes is configured directly
    -- in nvim/after/plugin/prose.lua (no plugin required).
    "rudism/telescope-dict.nvim",

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
            threshold = 7, -- hbac will start closing unedited buffers once that number is reached
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

    {
        "danymat/neogen",
        opts = {
            snippet_engine = "luasnip",
        },
        keys = {
            { "<leader>doc", function() require("neogen").generate() end, desc = "Generate doc comment" },
        },
    },

    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {},
    },

    { "kevinhwang91/nvim-bqf", ft = "qf" },

    {
        "atiladefreitas/dooing",
        config = function()
            require("dooing").setup({
                window = {
                    width = 100,
                    height = 100,
                },
                quick_keys = false,
            })
        end,
    },

    {
        "karb94/neoscroll.nvim",
        opts = {
            respect_scrolloff = true,
            stop_eof = false,
        },
    },
    {
        "mikesmithgh/kitty-scrollback.nvim",
        enabled = true,
        lazy = true,
        cmd = {
            "KittyScrollbackGenerateKittens",
            "KittyScrollbackCheckHealth",
            "KittyScrollbackGenerateCommandLineEditing",
        },
        event = { "User KittyScrollbackLaunch" },
        version = "*",
        config = function() require("kitty-scrollback").setup() end,
    },
}
