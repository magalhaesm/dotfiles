local util = require("config.util")

local function large_preview(_, cols, _)
  if cols > 200 then
    return math.floor(cols * 0.4)
  else
    return math.floor(cols * 0.6)
  end
end

local opts = {
  symbols = {
    "Class",
    "Function",
    "Method",
    "Constructor",
    "Interface",
    "Module",
    "Struct",
    "Trait",
    "Field",
    "Property",
  }
}

return {
  -- [[ Fuzzy Finder ]]
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    version = "*",
    keys = {
      { "<leader>/", util.telescope("live_grep"), desc = "Find in Files (Grep)" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "[B]uffers" },
      { "<leader>ff", util.telescope("files"), desc = "[F]iles (root dir)" },
      { "<leader>fF", util.telescope("files", { cwd = false }), desc = "[F]iles (cwd)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "[R]ecent" },
      { "<leader><space>", util.telescope("files"), desc = "[F]ind Files (root dir)" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "[C]ommits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "[S]tatus" },
      -- search
      { "<leader>sw", "<cmd>Telescope grep_string<CR>", desc = "[W]ord" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "[B]uffer" },
      { "<leader>sh", "<cmd>Telescope help_tags<CR>", desc = "Help Pages" },
      { "<leader>sc", "<cmd>Telescope commands<CR>", desc = "[C]ommands" },
      { "<leader>sC", "<cmd>Telescope command_history<CR>", desc = "[C]ommand History" },
      { "<leader>sh", "<cmd>Telescope help_tags<CR>", desc = "[H]elp Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<CR>", desc = "Search [H]ighlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<CR>", desc = "[K]ey Maps" },
      { "<leader>sm", "<cmd>Telescope marks<CR>", desc = "Jump to [M]ark" },
      { "<leader>sM", "<cmd>Telescope man_pages<CR>", desc = "[M]an Pages" },
      { "<leader>so", "<cmd>Telescope vim_options<CR>", desc = "Options" },
      {
        "<leader>ss",
        util.telescope("lsp_document_symbols", opts),
        desc = "Document [s]ymbol",
      },
      {
        "<leader>sS",
        util.telescope("lsp_workspace_symbols", opts),
        desc = "Workspace [S]ymbol",
      },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        winblend = 3,
        path_display = { "smart", "absolute", "truncate" },
        file_ignore_patterns = {
          "%.o",
          "%.jpg",
          "%.jpeg",
          "%.png",
          "%.otf",
          "%.ttf",
          "%.gif",
          ".git/",
        },
        layout_strategy = "horizontal",
        layout_config = {
          width = 0.95,
          height = 0.85,
          horizontal = {
            preview_width = large_preview,
          },
          vertical = {
            width = 0.9,
            height = 0.95,
            preview_height = 0.5,
          },
          flex = {
            horizontal = {
              preview_width = 0.9,
            },
          },
        },
        mappings = {
          i = {
            ["<C-j>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-k>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
          },
        },
      },
      pickers = {
        buffers = {
          sort_mru = true,
          sort_lastused = true,
          show_all_buffers = true,
          theme = "dropdown",
          previewer = false,
        },
        live_grep = {
          hidden = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
        },
      },
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
    end,
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
}
