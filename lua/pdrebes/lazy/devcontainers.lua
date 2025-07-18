return {
	"https://codeberg.org/esensar/nvim-dev-container",
	lazy = true,
	config = function()
		require("devcontainer").setup({})
	end,
}
