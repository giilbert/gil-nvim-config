local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- package manager
  use 'folke/tokyonight.nvim' -- theme
  use 'neovim/nvim-lspconfig' -- language server
  use 'christoomey/vim-tmux-navigator' -- make tmux with panes
  use 'lewis6991/gitsigns.nvim' -- git integration for buffers

  use {
    "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = { 
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      }
    }
  -- use 'kyazdani42/nvim-tree.lua'

  use 'hrsh7th/cmp-nvim-lsp' -- completion
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'dcampos/nvim-snippy'
  use 'dcampos/cmp-snippy'
  use 'tamago324/cmp-zsh'

  use 'ryanoasis/vim-devicons' -- fancy icons
  use 'feline-nvim/feline.nvim' -- status bar at bottom
  use 'mhartington/formatter.nvim' -- formatting
  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
  use {
    "folke/trouble.nvim", -- shows problems
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }
  use {
    'nvim-telescope/telescope.nvim', -- fuzzy finder
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'pantharshit00/vim-prisma' -- prisma lsp
  use 'tpope/vim-commentary' -- comment things out
  use {
    'nvim-treesitter/nvim-treesitter', -- treesitter
    run = ':TSUpdate'
  }
  use 'windwp/nvim-ts-autotag' -- closes html tags

  -- themes
  use 'navarasu/onedark.nvim'
  use 'tiagovla/tokyodark.nvim'
  use 'andweeb/presence.nvim'
end)

vim.g.tokyonight_style = "night"
require('onedark').setup({ style = 'warmer' })
require('onedark').load()

local map = vim.api.nvim_set_keymap
map('i', '<C-H>', '<C-W>', { noremap = true })

require('config.feline').setup()
require('config.neo-tree').setup()
require("config.bufferline").setup()
require("config.lsp").setup()

vim.cmd [[colorscheme onedark]]

require('gitsigns').setup()

require("presence"):setup()
