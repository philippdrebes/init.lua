-- Native Neovim treesitter
-- Parsers bundled with Neovim 0.12: lua, vim, vimdoc, bash, python, c, markdown, markdown_inline, query
--
-- All other parsers are compiled .so files placed in ~/.local/share/nvim/parser/
-- Run scripts/install-parsers.sh on each machine to set them up.

local parser_dir = vim.fn.stdpath("data") .. "/parser/"

-- Custom parsers: register only if the .so has been compiled and placed.
local custom_parsers = {
    { lang = "templ",  file = "templ.so" },
    { lang = "gotmpl", file = "gotmpl.so" },
    { lang = "blade",  file = "blade.so" },
}

for _, p in ipairs(custom_parsers) do
    local path = parser_dir .. p.file
    if vim.uv.fs_stat(path) then
        vim.treesitter.language.add(p.lang, { path = path })
    end
end

-- gotmpl is used by multiple filetypes
vim.treesitter.language.register("gotmpl", "gohtmltmpl")
vim.treesitter.language.register("gotmpl", "gotexttmpl")

vim.treesitter.language.register("templ", "templ")
vim.treesitter.language.register("c_sharp", "cs")

vim.filetype.add({
    pattern = {
        [".*%.blade%.php"] = "blade",
    },
})

return {}
