return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false, -- the `main` branch does not support lazy-loading
	branch = "main",
	build = ":TSUpdate",
	config = function()
		-- Filetype <-> parser registration (parser name differs from filetype).
		-- templ/gotmpl/blade are all built-in parsers on the `main` branch, so
		-- no custom `install_info` is needed -- only filetype wiring.
		vim.treesitter.language.register("gotmpl", { "gohtmltmpl", "gotexttmpl", "gotmpl" })
		vim.treesitter.language.register("blade", "blade")
		vim.filetype.add({
			pattern = {
				[".*%.blade%.php"] = "blade",
			},
		})

		-- Install parsers (async). Replaces the old `ensure_installed` +
		-- `auto_install`; any filetype whose parser is not listed here simply
		-- won't get tree-sitter features.
		require("nvim-treesitter").install({
			"vimdoc",
			"javascript",
			"typescript",
			"lua",
			"rust",
			"jsdoc",
			"bash",
			"python",
			"go",
			"yaml",
			"json",
			"templ",
			"gotmpl",
			"blade",
		})

		-- Enable highlighting + (experimental) indentation per buffer.
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local ft = vim.bo[args.buf].filetype
				if not pcall(vim.treesitter.start, args.buf) then
					return
				end
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				-- preserve old additional_vim_regex_highlighting for markdown
				if ft == "markdown" then
					vim.bo[args.buf].syntax = "on"
				end
			end,
		})
	end,
}
