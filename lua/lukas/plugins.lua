local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- Common plugins
  use("wbthomason/packer.nvim") -- Have packer manage itself
  use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
  use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
  use("kyazdani42/nvim-web-devicons") -- Display beautiful icons theme
  use("kyazdani42/nvim-tree.lua")
  use("norcalli/nvim-colorizer.lua")
  use("akinsho/bufferline.nvim")
  use("moll/vim-bbye")
  use("tpope/vim-surround")
  use("easymotion/vim-easymotion")

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use("lunarvim/darkplus.nvim")
  use("rebelot/kanagawa.nvim")
  use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })

  -- Completion plugins
  use("hrsh7th/nvim-cmp") -- The completion plugin
  use("hrsh7th/cmp-buffer") -- buffer completions
  use("hrsh7th/cmp-path") -- path completions
  use("hrsh7th/cmp-cmdline") -- cmdline completions
  use("saadparwaiz1/cmp_luasnip") -- snippet completions
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  -- snippets
  use("L3MON4D3/LuaSnip") --snippet engine
  use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

  -- LSP
  use("neovim/nvim-lspconfig") -- enable LSP
  use("williamboman/nvim-lsp-installer") --simple to use language server installer
  use("ray-x/lsp_signature.nvim")
  use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
  use({
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  })
  use("glepnir/lspsaga.nvim")

  -- Telescope
  use("nvim-telescope/telescope.nvim")
  use("nvim-telescope/telescope-media-files.nvim")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("windwp/nvim-ts-autotag")

  -- Misc
  use({ "akinsho/toggleterm.nvim" }) -- Toggle Terminal
  use("nvim-lualine/lualine.nvim")
  use("lewis6991/gitsigns.nvim")
  use("akinsho/git-conflict.nvim")
  use("numToStr/Comment.nvim") -- Auto comment
  use("windwp/nvim-autopairs") -- Autopairs
  use("p00f/nvim-ts-rainbow") -- Rainbow bracket
  use({ "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" }) -- todo highlight
  use("folke/which-key.nvim") -- WhichKey

  -- DAP
  use("mfussenegger/nvim-dap")
  use("theHamsta/nvim-dap-virtual-text")
  use("rcarriga/nvim-dap-ui")

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
