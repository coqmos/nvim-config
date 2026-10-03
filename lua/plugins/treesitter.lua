return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		-- Safely require treesitter with fallback
		local ok, configs = pcall(require, "nvim-treesitter.configs")
		if not ok then
			vim.notify("Treesitter loading deferred (will auto-install on file open)", vim.log.levels.INFO)
			return
		end

		-- Simplified config for Neovim 0.12 compatibility
		configs.setup({
			ensure_installed = { "lua", "javascript", "typescript", "php" },
			sync_install = false,
			auto_install = true,
			indent = {
				enable = true
			},
			highlight = {
				enable = true,
				-- Disable for large files to avoid performance issues
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
		})
	end
}
