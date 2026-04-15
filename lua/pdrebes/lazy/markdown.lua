return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "echasnovski/mini.nvim" },
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		completions = {
			lsp = { enabled = true },
		},
		-- heading = { icons = { "󰼏 ", "󰎨 " } },
	},
}
