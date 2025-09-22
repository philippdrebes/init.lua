return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	keys = {
		{ "<leader>o", "<cmd>Oil<cr>", desc = "Oil" },
	},
	config = function()
		require("oil").setup({
			view_options = {
				show_hidden = true,
			},
		})
	end,
}
