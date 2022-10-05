_M = {}

_M.setup = function()
  require("neo-tree").setup({
    hijack_netrw_behavior = "open_default",

    window = {
      position = "left"
    }
  })

  vim.cmd[[
    map <silent> <C-n> :NeoTreeShowToggle<CR>
  ]]
end

return _M
