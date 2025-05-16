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
			blade = { "blade-formatter", "rustywind" },
			csharp = { "csharpier" },
			css = { "prettier" },
			graphql = { "prettier" },
			html = { "prettier" },
			htmldjango = { "prettier", "djlint" },
			java = { "google-java-format" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			json = { "prettier" },
			lua = { "stylua" },
			markdown = { "prettier" },
			php = { "pint" },
			python = { "isort", "yapf" },
			sql = { "sql-formatter" },
			svelte = { "prettier" },
			tex = { "latexindent" },
			typescript = { "prettier" },
			typescriptreact = { "tailwindcss", "prettier" },
			vue = { "tailwindcss", "prettier" },
			xml = { "xmlformatter" },
			yaml = { "yamlfmt", "prettier" },
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
