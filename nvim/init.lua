-- Configuración general
vim.opt.clipboard = "unnamedplus"  -- Usar el portapapeles del sistema
vim.opt.tabstop = 4                -- Ancho de tabulación
vim.opt.shiftwidth = 4             -- Ancho de la sangría
vim.opt.relativenumber = true      -- Números de línea relativos
vim.opt.number = true              -- Mostrar números de línea
vim.opt.expandtab = true           -- Convertir tabs a espacios
vim.opt.termguicolors = true       -- Habilitar colores 24 bits
vim.g.mapleader = 'ñ'              -- Líder de teclas

-- Remapeo para salir de la terminal Ctrl + x
vim.api.nvim_set_keymap('t', '<C-x>', [[<C-\><C-n>]], {noremap = true, silent = true})

-- Función para abrir una terminal en la parte inferior
function _G.open_terminal_bottom()
  -- Cierra cualquier ventana activa de terminal y abre una nueva en la parte inferior
  vim.cmd('belowright split | term')
  -- Ajusta el tamaño de la ventana para que ocupe el 20% inferior de la pantalla
  vim.cmd('resize ' .. math.floor(vim.o.lines * 0.2))
end

-- Mapea una combinación de teclas para abrir la terminal en la parte inferior
vim.api.nvim_set_keymap('n', '<leader>t', [[:lua open_terminal_bottom()<CR>]], { noremap = true, silent = true })

-- Configuración para Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- última versión estable
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Inicializar Lazy y cargar los plugins
require("lazy").setup({
  -- Tema y pares automáticos
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight-storm]])
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup{}
    end
  },

  -- LSP para PHP
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.intelephense.setup{} -- Soporte para PHP con Intelephense
      lspconfig.pyright.setup{}      -- Soporte para Python con Pyright
    end
  },

  -- Instalador de servidores LSP
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  -- Autocompletado
  {
    "hrsh7th/nvim-cmp", -- Motor de autocompletado
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Fuente de autocompletado basada en LSP
      "hrsh7th/cmp-buffer",   -- Fuente de autocompletado basada en buffer
      "hrsh7th/cmp-path",     -- Fuente de autocompletado basada en rutas
      "hrsh7th/cmp-cmdline",  -- Fuente de autocompletado para línea de comandos
      "L3MON4D3/LuaSnip",     -- Snippets
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' }, -- Para PHP (Intelephense)
          { name = 'buffer' },   -- Para autocompletar desde el buffer
        })
      })
    end,
  },

  -- Resaltado y detección de sintaxis avanzada
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "php", "python" },
        highlight = { enable = true },
        indent = { enable = true },
      }
    end
  },

  -- Explorador de archivos
  {
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons", -- Para íconos de archivos
    },
    config = function()
      require('nvim-tree').setup {}
    end,
  },

  -- Barra de estado
  {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require('lualine').setup {
        options = { theme = 'tokyonight' }
      }
    end,
  },
})

-- Otras configuraciones adicionales
vim.o.ignorecase = true      -- Ignorar mayúsculas/minúsculas en la búsqueda
vim.o.smartcase = true       -- Usar mayúsculas si hay alguna en la búsqueda
vim.o.hlsearch = true        -- Resaltar resultados de búsqueda
vim.o.mouse = 'a'            -- Habilitar el uso del ratón
vim.cmd('syntax on')         -- Habilitar el resaltado de sintaxis

-- Resaltar números de línea
vim.cmd [[highlight LineNr guifg=#ffffff guibg=#282828]]  -- Color de los números de línea
vim.cmd [[highlight CursorLineNr guifg=#ffcc00 guibg=#282828]] -- Color del número de línea actual

