-- configures everything with language intelligence

_M = {}

local map = vim.api.nvim_set_keymap

_M.setup = function()
  local border = {
        {"┌", "FloatBorder"},
        {"─", "FloatBorder"},
        {"┐", "FloatBorder"},
        {"│", "FloatBorder"},
        {"┘", "FloatBorder"},
        {"─", "FloatBorder"},
        {"└", "FloatBorder"},
        {"│", "FloatBorder"},
  }

  local handlers =  {
    ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
    ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
  }

  local opts = { noremap = true, silent = true }
  map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  map('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)


  local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    local bufmap = vim.api.nvim_buf_set_keymap

    bufmap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    bufmap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    bufmap(bufnr, 'n', '<space><space>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    bufmap(bufnr, 'n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    bufmap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    bufmap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    bufmap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    bufmap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    bufmap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    bufmap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    bufmap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    bufmap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    bufmap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  end

  local servers = { 'pyright', 'tsserver', 'eslint', 'prismals', 'clangd', 'rust_analyzer', 'astro', 'tailwindcss', 'html' }
  for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
      on_attach = on_attach,
      handlers = handlers,
      init_options = { documentFormatting = true },
      flags = {
        debounce_text_changes = 150,
        capabilities = capabilities
      },
    }
  end

require'lspconfig'.omnisharp.setup {
    cmd = { "dotnet", "/usr/bin/omnisharp/OmniSharp.dll" },
    enable_editorconfig_support = true,
    enable_ms_build_load_projects_on_demand = false,
    enable_roslyn_analyzers = false,
    organize_imports_on_format = false,
    enable_import_completion = false,
    sdk_include_prereleases = true,
    analyze_open_documents_only = false,
}

  require('nvim-treesitter.configs').setup({
    ensure_installed = { "python", "tsx", "typescript", "rust", "css", "html" },
    sync_install = false,
    auto_install = true,
    indent = {
      enable = false
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  })


  require('nvim-ts-autotag').setup()

  local cmp = require('cmp')

  require("tailwindcss-colorizer-cmp").setup({
    color_square_width = 4,
  })

  cmp.setup({
      formatting = {
        format = require("tailwindcss-colorizer-cmp").formatter
      },
      snippet = {
        expand = function(args)
          require('snippy').expand_snippet(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }), 
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
      }, {
        { name = 'buffer' },
      })
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })


  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  local prettier = {
      formatCommand = [[prettier --stdin-filepath ${INPUT} ${--tab-width:2}]],
      formatStdin = true,
  }

  vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1E1E21]]
  vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1E1E21]]
  vim.cmd [[colorscheme onedark]]


  require("formatter").setup({
    filetype = {
      ["typescriptreact"] = { require("formatter.filetypes.typescriptreact").prettier },
      ["typescript"] = { require("formatter.filetypes.typescript").prettier },
      ["javascript"] = { require("formatter.filetypes.javascript").prettier },
      ["rust"] = { require("formatter.filetypes.rust").rustfmt },
      ["html"] = { require("formatter.filetypes.html").prettier },
      ["css"] = { require("formatter.filetypes.css").prettier },
      ["python"] = { require("formatter.filetypes.python").black },
    }
  })

end

return _M

