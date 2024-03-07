local fc = require("neo-tree.sources.filesystem.components")

_M = {}

_M.setup = function()
  require("neo-tree").setup({
    close_if_last_window = false,
    hijack_netrw_behavior = "open_default",
    window = {
      position = "left"
    },
    filesystem = {
      components ={
        name = function(config, node, state)
          local result = fc.name(config, node, state)
          if node:get_depth() == 1 and node.type ~= "message" then
            result.text = vim.fn.fnamemodify(node.path, ":t")
          end
          return result
        end,
      },
    }
  })

  vim.cmd[[
    map <silent> <C-n> :NeoTreeShowToggle<CR>
  ]]
end

return _M
