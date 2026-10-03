return {
	"iamcco/markdown-preview.nvim",
	ft = "markdown",
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	config = function()
		-- Use Firefox for markdown preview (full path to avoid xdg-open issues)
		vim.g.mkdp_browser = '/usr/bin/firefox'

		vim.keymap.set("n", "<leader>mp", vim.cmd.MarkdownPreview, { desc = "Markdown Preview" })
		vim.keymap.set("n", "<leader>mc", vim.cmd.MarkdownPreviewStop, { desc = "Close Markdown Preview" })
	end,
}
