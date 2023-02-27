-- -----------------------------------------------------------------------------
-- General Settings
-- -----------------------------------------------------------------------------

lvim.colorscheme = "catppuccin-macchiato"
lvim.format_on_save.enabled = true
lvim.log.level = "warn"


-- -----------------------------------------------------------------------------
-- Keymappings
-- -----------------------------------------------------------------------------

lvim.leader = "space"

-- Cycle through buffers
lvim.keys.normal_mode["<S-Tab>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<Tab>"] = ":BufferLineCycleNext<CR>"

-- Exit insert mode with jk
lvim.keys.insert_mode["jk"] = "<ESC>"

-- Save file
lvim.keys.normal_mode["<C-s>"] = ":w<CR>"
lvim.keys.insert_mode["<C-s>"] = "<Esc>:w<CR>"


-- -----------------------------------------------------------------------------
-- Plugins (Built-in)
-- -----------------------------------------------------------------------------

-- Dashboard
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

-- Terminal
lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "horizontal"
lvim.builtin.terminal.open_mapping = [[<C-\>]]

-- NvimTree
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Treesitter
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.ensure_installed = {
  "css",
  "java",
  "javascript",
  "json",
  "lua",
  "python",
  "tsx",
  "typescript",
  "yaml",
}


-- -----------------------------------------------------------------------------
-- Plugins (Additional)
-- -----------------------------------------------------------------------------

lvim.plugins = {
  -- catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin"
  },

  -- nvim-surround
  {
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup()
    end
  },

  -- vim-prisma
  {
    'prisma/vim-prisma'
  },

  -- tailwind-sorter
  {
    "laytan/tailwind-sorter.nvim",
    requires = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
    config = function()
      require("tailwind-sorter").setup()
    end,
    run = "cd formatter && npm i && npm run build",
  }
}


-- -----------------------------------------------------------------------------
-- Formatters
-- -----------------------------------------------------------------------------

local formatters = require "lvim.lsp.null-ls.formatters"

formatters.setup {
  {
    command = "prettier",
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact"
    },
  },
}
