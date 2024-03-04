local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
  {'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' }},
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  {
    "kelly-lin/telescope-ag",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },

  {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'},
  'nvim-treesitter/playground',
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  'mbbill/undotree',
  'tpope/vim-fugitive',
  { dir = '~/.config/nvim/color/dracula_pro' },
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},

  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  {'L3MON4D3/LuaSnip'},
})


