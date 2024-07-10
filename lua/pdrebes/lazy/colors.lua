function ColorMyPencils()
	color = color or "rose-pine-moon"
	-- color = color or "dracula_pro"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			styles = {
				transparency = true,
			},
		})
		ColorMyPencils()
	end,
}

-- return {
-- 	dir = "~/.config/nvim/color/dracula_pro",
-- 	config = function()
-- 		ColorMyPencils()
-- 	end,
-- }

-- return {
-- 	dir = "~/.config/nvim/color/dracula_pro",
-- 	config = function()
-- 		ColorMyPencils()
-- 	end,
-- }
