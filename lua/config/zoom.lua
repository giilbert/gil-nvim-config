local function setup()
  vim.g.gui_font_default_size = 15
  vim.g.gui_font_size = vim.g.gui_font_default_size
  vim.g.gui_font_face = "FiraCode Nerd Font Mono"
  vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)

  if vim.g.neovide == true then
    vim.api.nvim_set_keymap("n", "<C-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>", { silent = true })
    vim.api.nvim_set_keymap("n", "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>", { silent = true })
    vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })
  end
end

_M = {}
_M.setup = setup
return _M
