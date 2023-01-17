-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}
	use('cljoly/telescope-repo.nvim')

	use({
		"EdenEast/nightfox.nvim",
		as = "nightfox",
		config = function()
			vim.cmd('colorscheme carbonfox')
		end
	})

	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdateSync' })
	use('theprimeagen/harpoon')
	use('mbbill/undotree')
	use('tpope/vim-surround')
	use('tpope/vim-fugitive')
	-- use('tpope/vim-sleuth')
	use('tpope/vim-commentary')

	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' },
			{ 'williamboman/mason.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-nvim-lua' },

			-- Snippets
			{ 'L3MON4D3/LuaSnip' },
			{ 'rafamadriz/friendly-snippets' },
		}
	}

	use {
		'rmagatti/alternate-toggler',
		config = function()
			vim.keymap.set("n", "<leader>b", "<cmd>lua require('alternate-toggler').toggleAlternate()<CR>")
		end,
		event = { "BufReadPost" }, -- lazy load after reading a buffer
	}

	use('preservim/vim-pencil')

	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional, for file icons
		},
	}
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use('nanozuki/tabby.nvim')
	use('simeji/winresizer')
	use('mg979/vim-visual-multi')
	use('sheerun/vim-polyglot')

	use {
		'glacambre/firenvim',
		run = function() vim.fn['firenvim#install'](0) end
	}

	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	}
	use("folke/neodev.nvim")

	use("Pocco81/auto-save.nvim")

end)
