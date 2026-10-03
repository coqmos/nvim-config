return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		-- Defines a read-write directory for treesitters in nvim's cache dir
		local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
		vim.fn.mkdir(parser_install_dir, "p")
		-- Prevents reinstall of treesitter plugins every boot
		vim.opt.runtimepath:append(parser_install_dir)


		require("nvim-treesitter.configs").setup({
  			parser_install_dir = parser_install_dir,
			ensure_installed = {"javascript", "php", "typescript", "lua"},
			sync_install = false,
			auto_install = true,
			indent = {
				enabled = true
			},
			highlight = {
				enabled = true
			},
			additional_vim_regex_highlighting = {"markdown"},
		})
	end
}
