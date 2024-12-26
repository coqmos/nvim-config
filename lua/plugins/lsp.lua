return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason-lspconfig").setup()
		require("mason").setup()
		require('lspconfig').pyright.setup{}

	end
}
