return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },

  {
    "folke/tokyonight.nvim",
    name = "tokyo-night",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      -- transparent = true
    },
  },

  -- {
  --   "IogaMaster/neocord",
  --   event = "VeryLazy",
  --   config = function()
  --     require "configs.neocord"
  --   end,
  -- },

  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.presence"
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require "configs.neotree"
    end,
  },

  {
    "github/copilot.vim",
    cmd = "Copilot",
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    branch = "canary",
    build = "make tiktoken",
    opts = {
      -- See Configuration section for options
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "configs.telescope"
    end,
  },

  -- {
  --   "akinsho/bufferline.nvim",
  --   event = "BufReadPre",
  --   config = function()
  --     require "configs.bufferline"
  --   end,
  -- },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "configs.lualine"
    end,
    event = "VeryLazy",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "html",
        "cssls",
        "gopls",
        "glint",
        "pyright",
        "intelephense",
        "lua_ls",
        "rust_analyzer",
      },
    },
  },
  {
    "jwalton512/vim-blade",
    ft = "blade",
  },
}
