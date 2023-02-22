local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local builtin = require "telescope.builtin"
local actions = require "telescope.actions"

local function large_preview(_, cols, _)
  if cols > 200 then
    return math.floor(cols * 0.4)
  else
    return math.floor(cols * 0.6)
  end
end

telescope.setup {
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
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,

        ["<C-j>"] = actions.cycle_history_next,
        ["<C-k>"] = actions.cycle_history_prev,

        ["<c-s>"] = actions.select_horizontal,
        ["<c-v>"] = actions.select_vertical,

        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-c>"] = actions.close,
        ["<CR>"] = actions.select_default + actions.center,
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
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
    },
  },
}

require("telescope").load_extension "fzf"

function mm.config_zsh()
  builtin.git_files {
    prompt_title = "Zsh Config",
    cwd = "~/.config/zsh/",
    use_git_root = false,
  }
end

function mm.config_nvim()
  builtin.git_files {
    prompt_title = "Nvim Config",
    cwd = "~/.config/nvim/",
    use_git_root = false,
  }
end

function mm.config_tmux()
  builtin.git_files {
    prompt_title = "Tmux Config",
    cwd = "~/.config/tmux/",
    use_git_root = false,
  }
end

nnoremap("<leader>b", "<cmd>Telescope buffers<CR>", "Buffers")
nnoremap("<leader>r", "<cmd>Telescope oldfiles<CR>", "Recent")
nnoremap("<leader>F", "<cmd>Telescope live_grep<CR>", "Text")

map.nname("<leader>f", "Find")
nnoremap("<leader>ff", mm.telescope "find_files", "Files")
nnoremap("<leader>fo", "<cmd>Telescope grep_string<CR>", "Occurrences")
nnoremap("<leader>fg", "<cmd>Telescope git_files<CR>", "Git files")
nnoremap("<leader>fr", "<cmd>Telescope oldfiles<CR>", "Recent")
nnoremap("<leader>fp", "<cmd>Telescope projects<CR>", "Projects")
nnoremap("<leader>fC", "<cmd>Telescope commands<CR>", "Commands")
nnoremap("<leader>fm", "<cmd>Telescope man_pages<CR>", "Manual")
nnoremap("<leader>fR", "<cmd>Telescope registers<CR>", "Registers")
nnoremap("<leader>/", "<cmd>Telescope help_tags<CR>", "Help")
nnoremap("<leader>fk", "<cmd>Telescope keymaps<CR>", "Keymaps")
nnoremap("<leader>fO", "<cmd>Telescope vim_options<CR>", "Vim options")
nnoremap(
  "<leader>ss",
  mm.telescope("lsp_document_symbols", {
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
    },
  }), "Goto Symbols"
)
nnoremap(
  "<leader>sS",
  mm.telescope("lsp_workspace_symbols", {
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
    },
  }), "Goto Symbols (Workspace)"
)

nnoremap("<leader>fz", "<cmd>lua mm.config_zsh()<CR>", "Zsh")
nnoremap("<leader>fn", "<cmd>lua mm.config_nvim()<CR>", "Nvim")
nnoremap("<leader>ft", "<cmd>lua mm.config_tmux()<CR>", "Tmux")
