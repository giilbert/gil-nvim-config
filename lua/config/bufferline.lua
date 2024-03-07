_M = {}

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

_M.setup = function() 
  map('n', '<A-q>', '<Cmd>BufferLinePickClose<CR>', opts)
  map('n', '<A-w>', '<Cmd>BufferLineCyclePrev<CR>', opts)
  map('n', '<A-e>', '<Cmd>BufferLineCycleNext<CR>', opts)
  map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
  map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)

  map('n', '<A-1>', '<Cmd>BufferLineGoToBuffer 1<CR>', opts)
  map('n', '<A-2>', '<Cmd>BufferLineGoToBuffer 2<CR>', opts)
  map('n', '<A-3>', '<Cmd>BufferLineGoToBuffer 3<CR>', opts)
  map('n', '<A-4>', '<Cmd>BufferLineGoToBuffer 4<CR>', opts)
  map('n', '<A-5>', '<Cmd>BufferLineGoToBuffer 5<CR>', opts)
  map('n', '<A-6>', '<Cmd>BufferLineGoToBuffer 6<CR>', opts)
  map('n', '<A-7>', '<Cmd>BufferLineGoToBuffer 7<CR>', opts)
  map('n', '<A-8>', '<Cmd>BufferLineGoToBuffer 8<CR>', opts)
  map('n', '<A-9>', '<Cmd>BufferLineGoToBuffer 9<CR>', opts)

  map('n', '<A-p>', '<Cmd>BufferPick<CR>', opts)
  map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
  map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
  map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
  map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

  map('n', 'ZZ', '<Cmd>bp | bd #<CR>', opts)
  
  require("bufferline").setup({
    highlights = {
      fill = {
        bg = {
          attribute = "bg",
          highlight = "Normal"
        }
      }
    },
    options = {
      offsets = {
        {
          filetype = "neo-tree",
          text = "",
          highlight = "NeoTreeNormal",
          text_align = "center"
        }
      }
    }
  })
end

return _M
