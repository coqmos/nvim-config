local M = {
	'williamboman/mason.nvim',
	dependencies = {
		'williamboman/mason-lspconfig.nvim',
		'nvim-lua/plenary.nvim',
	},
}

M.servers = {
	"lua_ls",
	"pyright"
}

function M.config()
	require("mason").setup()

	require("mason-lspconfig").setup {
		ensure_installed = M.servers,
		automatic_installation = true,
		handlers = {
			function(server_name)
				require("lspconfig")[server_name].setup({})
			end,
		},
	}
end

return M
