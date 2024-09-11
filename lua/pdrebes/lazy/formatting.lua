return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "n",
			desc = "Format buffer",
		},
	},
	-- Everything in opts will be passed to setup()
	opts = {
		-- Define your formatters
		formatters_by_ft = {
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "tailwindcss", "prettier" },
			svelte = { "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			htmldjango = { "prettier", "djlint" },
			json = { "prettier" },
			yaml = { "yamlfmt", "prettier" },
			xml = { "xmlformatter" },
			markdown = { "prettier" },
			graphql = { "prettier" },
			lua = { "stylua" },
			python = { "isort", "yapf" },
			sql = { "sql-formatter" },
			tex = { "latexindent" },
			csharp = { "csharpier" },
		},
		-- Set up format-on-save
		format_on_save = { timeout_ms = 800, lsp_fallback = true },
		-- Customize formatters
		-- formatters = {
		-- 	shfmt = {
		-- 		prepend_args = { "-i", "2" },
		-- 	},
		-- },
	},
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
