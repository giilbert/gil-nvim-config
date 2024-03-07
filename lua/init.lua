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
  use 'nvim-treesitter/nvim-treesitter-context'

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
  use "olimorris/onedarkpro.nvim"
  use 'andweeb/presence.nvim'

  use "roobert/tailwindcss-colorizer-cmp.nvim"
  use "github/copilot.vim"

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use "goolord/alpha-nvim"

  use({
    "kdheepak/lazygit.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })

  use "rebelot/heirline.nvim"

  use({
    "folke/noice.nvim",
    requires = { "MunifTanjim/nui.nvim" },
  })
end)

-- require('onedark').setup({ style = 'darker' })
-- require('onedark').load()
vim.cmd [[colorscheme onedark]]


local map = vim.api.nvim_set_keymap
map('i', '<C-H>', '<C-W>', { noremap = true })

local CONFIG_MODULES = {
  "config.zoom",
  "config.neo-tree",
  "config.lsp",
  -- "config.heirline",
  "config.bufferline",
  "config.lualine",
  "config.alpha",
}

for _, module in ipairs(CONFIG_MODULES)
do
  local status, err = pcall(require(module).setup)
  if err then 
    vim.notify("Failed to load " .. module .. " with error: \n" .. err, vim.log.levels.ERROR)
  end
end

require('gitsigns').setup()
require("presence").setup()

vim.filetype.add({
  extension = {
    astro = "astro",
  },
})

vim.go.cmdheight = 0

require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  messages = {
    view = false,
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})
