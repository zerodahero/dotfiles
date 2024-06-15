return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {{'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-ui-select.nvim'}},
    },

    'nvim-telescope/telescope-dap.nvim',
    'gbrlsnchs/telescope-lsp-handlers.nvim',
    'keyvchan/telescope-find-pickers.nvim',

    {'EdenEast/nightfox.nvim', name = 'nightfox'},

    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    'nvim-treesitter/playground',
    'JoosepAlviste/nvim-ts-context-commentstring',

    'mbbill/undotree',
    'tpope/vim-surround',
    'tpope/vim-fugitive',
    {'akinsho/git-conflict.nvim', version = '*', config = true},

    'APZelos/blamer.nvim',
    'tpope/tpope-vim-abolish',

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim', build = ':MasonUpdate'},
            -- { 'williamboman/mason.nvim' },
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lsp-signature-help'},

            -- Snippets
            {'L3MON4D3/LuaSnip', version = 'v2.*', build = 'make install_jsregexp'},
            -- {'rafamadriz/friendly-snippets'},

            -- null-ls
            -- { 'nvimtools/none-ls.nvim' },
            -- { 'jay-babu/mason-null-ls.nvim' },

            -- formatter
            -- {'mhartington/formatter.nvim'},

            -- linter
            {'mfussenegger/nvim-lint'},

            -- nvim lua config
            {'folke/neodev.nvim'},

            -- lsp status updates
            {'j-hui/fidget.nvim'},

            -- lsp overloads
            {'Issafalcon/lsp-overloads.nvim'},

            -- {'nvimdev/lspsaga.nvim', after = 'nvim-lspconfig'}
        },
    },
    'Hoffs/omnisharp-extended-lsp.nvim',
    {'benfowler/telescope-luasnip.nvim', module = 'telescope._extensions.luasnip'},
    'adoyle-h/lsp-toggle.nvim',

    -- Debugging
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            -- UI
            {'rcarriga/nvim-dap-ui'},
            {'theHamsta/nvim-dap-virtual-text'},

            -- Adapters
            {'mxsdev/nvim-dap-vscode-js'},
            {
                'microsoft/vscode-js-debug',
                lazy = true,
                build = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out',
            },
        },
    },

    'ray-x/lsp_signature.nvim',

    'SmiteshP/nvim-navic',
    'lukas-reineke/indent-blankline.nvim',

    {
        'rmagatti/alternate-toggler',
        config = function()
            vim.keymap.set('n', '<leader>b',
                           function() require('alternate-toggler').toggleAlternate() end)
        end,
        event = {'BufReadPost'}, -- lazy load after reading a buffer
    },
    {'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup {} end},
    -- {
    --     'Wansmer/treesj',
    --     keys = {{'J', '<cmd>TSJToggle<cr>', desc = 'Join Toggle'}},
    --     opts = {use_default_keymaps = false, max_join_length = 150},
    -- },

    -- Configured in prose.lua
    'preservim/vim-pencil',
    'preservim/vim-wordy',
    'rudism/telescope-dict.nvim',
    'dbmrq/vim-ditto',
    -- 'preservim/vim-lexical'

    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
    },
    {'nvim-lualine/lualine.nvim', dependencies = {'nvim-tree/nvim-web-devicons', opt = true}},
    {'akinsho/bufferline.nvim', version = '*', dependencies = 'nvim-tree/nvim-web-devicons'},

    'simeji/winresizer',
    {'kwkarlwang/bufresize.nvim', config = function() require('bufresize').setup() end},

    -- 'sheerun/vim-polyglot',

    'echasnovski/mini.nvim',

    {'glacambre/firenvim', build = function() vim.fn['firenvim#install'](0) end},

    {
        'folke/trouble.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function() require('trouble').setup {} end,
    },

    -- {
    --     'pocco81/auto-save.nvim',
    --     config = function()
    --         require('auto-save').setup {
    --             enabled = false,
    --             trigger_events = {'TextChanged'},
    --             debounce_delay = 1000,
    --         }
    --     end,
    -- },

    -- Little floating window with file name
    'b0o/incline.nvim',

    -- Buffer closing without closing windows
    'moll/vim-bbye',
    'arithran/vim-delete-hidden-buffers',
    'axkirillov/hbac.nvim',

    -- Scratch
    -- 'LintaoAmons/scratch.nvim',

    'HiPhish/rainbow-delimiters.nvim',
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            -- 'antoinemadec/FixCursorHold.nvim', -- supposedly not needed anymore?
            'olimorris/neotest-phpunit',
            'Issafalcon/neotest-dotnet',
            'ChristianChiarulli/neovim-codicons',
            'nvim-neotest/neotest-jest',
        },
    },
    {'folke/twilight.nvim', opts = {} },
    {'folke/zen-mode.nvim', opts = {} },

    -- DOcument GEnterator (docblocks, etc)
    {'kkoomen/vim-doge', build = ':call doge#install()'},

    {
        'folke/todo-comments.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function() require('todo-comments').setup {} end,
    },
    {'numToStr/Comment.nvim', config = function() require('Comment').setup() end},

    'hedyhli/outline.nvim',
    'terrastruct/d2-vim',

    {
        'chentoast/marks.nvim',
        event = 'BufReadPre',
        config = function() require('marks').setup {} end,
    },

    -- AI
    -- 'Exafunction/codeium.vim',
    -- 'github/copilot.vim',
}
