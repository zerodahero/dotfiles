-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-ui-select.nvim'},
        },
    }

    use {'nvim-telescope/telescope-dap.nvim'}
    use {'gbrlsnchs/telescope-lsp-handlers.nvim'}
    use {'keyvchan/telescope-find-pickers.nvim'}

    use({
        'EdenEast/nightfox.nvim',
        as = 'nightfox',
        config = function() vim.cmd('colorscheme carbonfox') end,
    })
    -- use({
    --     'folke/tokyonight.nvim',
    --     config = function () vim.cmd('colorscheme tokyonight-night') end
    -- })
    -- use({
    --     'bluz71/vim-moonfly-colors',
    --     config = function () vim.cmd('colorscheme moonfly') end
    -- })
    -- use({
    --     "lunarvim/onedarker.nvim",
    --     config = function () vim.cmd('colorscheme onedarker') end
    -- })

    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdateSync'})
    -- use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-surround')
    use('tpope/vim-fugitive')
    use('APZelos/blamer.nvim')
    use('tpope/tpope-vim-abolish')
    -- use('tpope/vim-sleuth')
    -- use('tpope/vim-commentary')

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim', run = ":MasonUpdate"},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lsp-signature-help'},
            -- {
            --     'windwp/nvim-autopairs',
            --     config = function()
            --         require('nvim-autopairs').setup {enable_moveright = true}
            --     end,
            -- },

            -- Snippets
            {'L3MON4D3/LuaSnip', run = 'make install_jsregexp'},
            -- {'rafamadriz/friendly-snippets'},

            -- null-ls
            {'jose-elias-alvarez/null-ls.nvim'},
            {'jay-babu/mason-null-ls.nvim'},

            -- nvim lua config
            {'folke/neodev.nvim'},

            -- lsp status updates
            {'j-hui/fidget.nvim'},
        },
    }
    use {'Hoffs/omnisharp-extended-lsp.nvim'}
    use {
        'benfowler/telescope-luasnip.nvim',
        module = 'telescope._extensions.luasnip',
    }
    use {'adoyle-h/lsp-toggle.nvim'}
    use {'rcarriga/nvim-dap-ui', requires = {'mfussenegger/nvim-dap'}}
    use {'ray-x/lsp_signature.nvim'}

    use {
        'rmagatti/alternate-toggler',
        config = function()
            vim.keymap.set('n', '<leader>b', function()
                require('alternate-toggler').toggleAlternate()
            end)
        end,
        event = {'BufReadPost'}, -- lazy load after reading a buffer
    }

    -- Configured in prose.lua
    use {'preservim/vim-pencil'}
    use {'preservim/vim-wordy'}
    use {'rudism/telescope-dict.nvim'}
    use {'dbmrq/vim-ditto'}
    -- use {'preservim/vim-lexical'}

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
    }
    use {
        'akinsho/bufferline.nvim',
        tag = 'v3.*',
        requires = 'nvim-tree/nvim-web-devicons',
    }

    use {'simeji/winresizer'}
    use {'mg979/vim-visual-multi'}
    use {'sheerun/vim-polyglot'}

    use {'echasnovski/mini.nvim'}

    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end,
    }

    use {
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require('trouble').setup {} end,
    }

    use({
        'Pocco81/auto-save.nvim',
        config = function()
            require('auto-save').setup {
                enabled = false,
                trigger_events = {'TextChanged'},
                debounce_delay = 1000,
            }
        end,
    })

    -- Little floating window with file name
    use('b0o/incline.nvim')

    -- Buffer closing without closing windows
    use('moll/vim-bbye')

    use('HiPhish/nvim-ts-rainbow2')
    use {
        'nvim-neotest/neotest',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            -- 'antoinemadec/FixCursorHold.nvim', -- supposedly no needed anymore?
            'olimorris/neotest-phpunit',
            'Issafalcon/neotest-dotnet',
            'ChristianChiarulli/neovim-codicons',
        },
    }
    use {
        'folke/twilight.nvim',
        config = function() require('twilight').setup {} end,
    }
    use {
        'folke/zen-mode.nvim',
        config = function() require('zen-mode').setup {} end,
    }

    -- DOcument GEnterator (docblocks, etc)
    use {'kkoomen/vim-doge', run = ':call doge#install()'}

    use {
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('todo-comments').setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end,
    }

    use('terrastruct/d2-vim')
end)
