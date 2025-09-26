return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Telescope configuration
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    opts = {
      defaults = {
        -- Arguments passed to the external grep tool (ripgrep: 'rg')
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          
          -- === FILTERS TO INCLUDE IGNORED/HIDDEN FILES ===
          "--hidden",          -- Include files in hidden directories (like .config)
          "--no-ignore-vcs",   -- Override .gitignore rules
          -- You can also add --no-ignore if you have .ignore or .rgignore files
          -- which you want to bypass:
          -- "--no-ignore",
        },
        
        -- When using find_files, ensure the picker itself knows about hidden files
        -- file_ignore_patterns = {
        --   -- Exclude common build/temp folders, but keep .config/nvim searchable
        --   "node_modules/",
        --   "target/",
        --   "%.git/",
        --   "%.svn/",
        -- },
      }
    },
  },

  -- NvimTree configuration to show all files
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = {
        enable = true,
        ignore = false,          -- Show files ignored by git
        show_on_dirs = true,     -- Show git status on directories
        show_on_open_dirs = true,
        timeout = 400,
      },
      renderer = {
        hidden_display = "all",  -- Show hidden files
        highlight_git = true,    -- Highlight git status
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      filters = {
        dotfiles = false,        -- Show dotfiles (files starting with .)
        git_clean = false,       -- Show files ignored by git
        git_ignored = false,     -- Show files ignored by git
        no_buffer = false,
        custom = {},             -- Remove any custom filters
        exclude = {},            -- Don't exclude any files
      },
      view = {
        adaptive_size = false,
        centralize_selection = false,
        width = 30,
        side = "left",
      },
      actions = {
        open_file = {
          resize_window = true,
        },
      },
      update_focused_file = {
        enable = true,
        update_root = false,
      },
    },
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
