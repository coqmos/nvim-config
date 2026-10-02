return {
	"iamcco/markdown-preview.nvim",
	ft = "markdown",
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	config = function()
		vim.keymap.set("n", "<leader>mp", vim.cmd.MarkdownPreview, { desc = "Markdown Preview" })
		vim.keymap.set("n", "<leader>mc", vim.cmd.MarkdownPreviewStop, { desc = "Close Markdown Preview" })
	end,
}
