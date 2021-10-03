local M = {}

function M.config()
  mm.which_key = {
    setup = {
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
          operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = true, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      -- add operators that will trigger motion and text object completion
      -- to enable all native operators, set the preset / operators plugin above
      operators = { gc = "Comments" },
      key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },
      window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "center", -- align columns left, center or right
      },
      ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
      show_help = true, -- show help message on the command line when the popup is visible
      triggers = "auto", -- automatically setup triggers
      -- triggers = {"<leader>"} -- or specify a list manually
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
      },
    },

    opts = {
      mode = "n", -- NORMAL mode
      -- prefix: use "<leader>f" for example for mapping everything related to finding files
      -- the prefix is prepended to every mapping part of `mappings`
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    },

    mappings = {
      ["/"] = { "<cmd>CommentToggle<CR>", "Comment" },
      ["w"] = { "<cmd>w!<CR>", "Save" },
      ["q"] = { "<cmd>q!<CR>", "Quit" },
      ["e"] = { "<cmd>lua require'nvim-tree'.toggle()<CR>", "Explorer" },
      ["u"] = { "<cmd>UndotreeShow<CR>", "UndoTree" },
      ["f"] = { "<cmd>Telescope find_files<CR>", "Find Files" },
      ["x"] = { "<cmd>bdelete<cr>", "Close buffer" },

      b = {
        name = "Buffer",
        -- c = { "<cmd>bdelete<cr>", "Close" },
        c = { "<cmd>mm.delete_buffer()<cr>", "Close" },
      },

      -- TODO: analisar estes atalhos. Não uso todos
      s = {
        name = "Search",
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        f = { "<cmd>Telescope find_files<cr>", "File" },
        h = { "<cmd>Telescope help_tags<cr>", "Help" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        w = { "<cmd>Telescope live_grep<cr>", "Words" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        c = { "<cmd>Telescope commands<cr>", "Commands" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Symbols" },
        t = { "<cmd>TodoTelescope<cr>", "Todos" },
      },

      S = {
        name = "Session",
        s = { "<cmd>SessionSave<cr>", "Save Session" },
        l = { "<cmd>SessionLoad<cr>", "Load Session" },
      },

      p = {
        name = "Packer",
        S = { "<cmd>PackerSync<cr>", "Sync" },
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        C = { "<cmd>PackerClean<cr>", "Clean" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        s = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
      },

      z = {
        name = "Zettelkasten",
        n = { "<cmd>lua mm.new_note()<cr>", "New Zettel" },
        z = { "<cmd>lua mm.zettelkasten()<cr>", "Zettelkasten" },
      },

      c = {
        name = "Configurations",
        n = { "<cmd>lua mm.edit_nvim()<cr>", "Nvim" },
        t = { "<cmd>lua mm.edit_tmux()<cr>", "Tmux" },
        z = { "<cmd>lua mm.edit_zsh()<cr>", "Zsh" },
        c = { "<cmd>lua mm.cookbook()<cr>", "CookBook" },
      },

      g = {
        name = "Git",
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        u = {
          "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
          "Undo Stage Hunk",
        },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        C = {
          "<cmd>Telescope git_bcommits<cr>",
          "Checkout commit(for current file)",
        },
      },
    },

    vopts = {
      mode = "v", -- VISUAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    },

    vmappings = {
      ["/"] = { ":CommentToggle<CR>", "Comment" },

      r = {
        name = "Refactoring",
        t = { "<Esc><cmd>lua mm.refactors()<cr>", "Refactors" },
        e = {
          [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
          "Extract function",
        },
        f = {
          [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
          "Extract function to file",
        },
      },
    },
  }

  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then
    return
  end

  which_key.setup(mm.which_key.setup)

  local opts = mm.which_key.opts
  local mappings = mm.which_key.mappings

  local vopts = mm.which_key.vopts
  local vmappings = mm.which_key.vmappings

  local wk = require "which-key"
  wk.register(mappings, opts)
  wk.register(vmappings, vopts)
end

M.config()
