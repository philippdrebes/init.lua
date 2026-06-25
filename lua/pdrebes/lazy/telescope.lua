return {
    {
        "nvim-telescope/telescope.nvim",

        -- master uses vim.treesitter directly (compatible with nvim-treesitter `main`);
        -- the old 0.1.6 tag crashed on `ft_to_lang` after the treesitter migration.
        branch = "master",

        dependencies = {
            "nvim-lua/plenary.nvim"
        },

        config = function()
            local telescope = require('telescope')
            telescope.setup({})

            local builtin = require('telescope.builtin')

            telescope.load_extension("ag")
            telescope.load_extension('fzf')

            vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>pws', function()
                local word = vim.fn.expand("<cword>")
                builtin.grep_string({ search = word })
            end)
            vim.keymap.set('n', '<leader>pWs', function()
                local word = vim.fn.expand("<cWORD>")
                builtin.grep_string({ search = word })
            end)
            vim.keymap.set('n', '<leader>ps', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end)
            vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
        end
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    {
        "kelly-lin/telescope-ag",
        dependencies = { "nvim-telescope/telescope.nvim" },
    },
}
