return {
    "NvChad/nvim-colorizer.lua",
    opts = {
        filetypes = {
            'css',
            'scss',
            'sass',
            'javascript',
            'typescript',
            html = {
                -- Available methods are false / true / "normal" / "lsp" / "both"
                -- True is same as normal
                tailwind = true, -- Enable tailwind colors
            }
        }
    }
}
