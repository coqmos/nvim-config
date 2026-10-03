local M = {
	'VonHeikemen/lsp-zero.nvim',
	branch = "v4.x",
	dependencies = {
		-- LSP support
		'neovim/nvim-lspconfig',

		-- Autocompletetion
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'saadparwaiz1/cmp_luasnip',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-nvim-lua',

		-- Snippets
		'L3MON4D3/LuaSnip',
		'rafamadriz/friendly-snippets',
	},
	config = function()
		local lsp_zero = require('lsp-zero')
		lsp_zero.setup()
	end,
}

return M
