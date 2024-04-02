function ColorMyPencils()
    color = color or "dracula_pro"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return
{
    dir = '~/.config/nvim/color/dracula_pro',
    config = function()
        ColorMyPencils()
    end
}
