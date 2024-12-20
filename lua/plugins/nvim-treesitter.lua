return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.install").compilers = { "zig" }
		require("nvim-treesitter.configs").setup({
			auto_install = true,
			ensure_installed = {
				"lua",
				"vim",
				"markdown",
				"markdown_inline",
				"bash",
				"c",
				"python",
				"rust",
				"json",
				"yaml",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
		})
	end,
}
