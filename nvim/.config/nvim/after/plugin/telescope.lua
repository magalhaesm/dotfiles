local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local builtin = require "telescope.builtin"
local actions = require "telescope.actions"
local themes = require "telescope.themes"

local function large_preview(_, cols, _)
  if cols > 200 then
    return math.floor(cols * 0.4)
  else
    return math.floor(cols * 0.6)
  end
end

local CONFIG_HOME = vim.env.XDG_CONFIG_HOME

telescope.setup {
  defaults = {

    prompt_prefix = "❯ ",
    selection_caret = " ",
    color_devicons = true,

    winblend = 3,
    path_display = { "smart", "absolute", "truncate" },
    file_ignore_patterns = { "%.jpg", "%.jpeg", "%.png", "%.otf", "%.ttf", "%.gif", ".git/" },

    -- selection_strategy = "reset",
    -- sorting_strategy = "ascending",
    -- scroll_strategy = "cycle",

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
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<c-s>"] = actions.select_horizontal,
        ["<c-v>"] = actions.select_vertical,

        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-c>"] = actions.close,
        ["<CR>"] = actions.select_default + actions.center,
      },
    },
  },
  pickers = {
    -- find_files = {
    --   hidden = true,
    -- },
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
    lsp_code_actions = {
      theme = "cursor",
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
    },
    frecency = {
      workspaces = {
        -- conf = CONFIG_HOME,
        nvim = CONFIG_HOME .. "/nvim",
        zsh = CONFIG_HOME .. "/zsh",
        tmux = CONFIG_HOME .. "/tmux",
      },
    },
  },
}

require("telescope").load_extension "fzf"
require("telescope").load_extension "frecency"

function mm.search_files()
  local opts = themes.get_dropdown {
    previewer = false,
    hidden = true,
  }
  builtin.find_files(opts)
end

function mm.search_recents()
  local opts = themes.get_dropdown {
    previewer = false,
  }
  builtin.oldfiles(opts)
end

function mm.edit_zsh()
  builtin.git_files {
    prompt_title = "Zsh Config",
    cwd = "~/.config/zsh/",
    use_git_root = false,
  }
end

function mm.edit_nvim()
  builtin.git_files {
    prompt_title = "Nvim Config",
    cwd = "~/.config/nvim/",
    use_git_root = false,
  }
end

function mm.edit_tmux()
  builtin.git_files {
    prompt_title = "Tmux Config",
    cwd = "~/.config/tmux/",
    use_git_root = false,
  }
end

-- TODO: would be better
function mm.cookbook()
  builtin.live_grep {
    prompt_title = "Cookbook",
    cwd = "~/Dev/Cookbook",
    file_ignore_patterns = { "LICENSE" },
  }
end

function mm.search_by_filetype()
  builtin.find_files {
    find_command = {
      "rg",
      "--files",
      "--type",
      vim.fn.input "Type: ",
    },
  }
end

function mm.vim_options()
  builtin.vim_options {
    prompt_title = "Option",
    layout_config = {
      width = 0.5,
    },
  }
end

function mm.frecency()
  local opts = themes.get_dropdown {
    hidden = false,
    previewer = false,
    shorten_path = true,
  }
  require("telescope").extensions.frecency.frecency(opts)
end

nnoremap("<leader>b", "<cmd>Telescope buffers<CR>", "Buffers")
nnoremap("<leader>f", "<cmd>lua mm.search_files()<CR>", "Files")
nnoremap("<leader>r", "<cmd>lua mm.frecency()<CR>", "Recents")
nnoremap("<leader>F", "<cmd>Telescope live_grep<CR>", "Text")

map.nname("<leader>s", "Search")
nnoremap("<leader>sf", "<cmd>Telescope find_files<CR>", "Files")
nnoremap("<leader>sg", "<cmd>Telescope git_files<CR>", "Git files")
nnoremap("<leader>sr", "<cmd>Telescope oldfiles<CR>", "Recent")
nnoremap("<leader>sp", "<cmd>Telescope projects<CR>", "Projects")
nnoremap("<leader>sC", "<cmd>Telescope commands<CR>", "Commands")
nnoremap("<leader>sm", "<cmd>Telescope man_pages<CR>", "Manual")
nnoremap("<leader>sR", "<cmd>Telescope registers<CR>", "Registers")
nnoremap("<leader>s?", "<cmd>Telescope help_tags<CR>", "Help")
nnoremap("<leader>sk", "<cmd>Telescope keymaps<CR>", "Keymaps")
nnoremap("<leader>so", "<cmd>lua mm.vim_options()<CR>", "Vim options")
nnoremap("<leader>st", "<cmd>lua mm.search_by_filetype()<CR>", "Filetype")

nnoremap("<leader>sz", "<cmd>lua mm.edit_zsh()<CR>", "Zsh")
nnoremap("<leader>sn", "<cmd>lua mm.edit_nvim()<CR>", "Nvim")
nnoremap("<leader>sT", "<cmd>lua mm.edit_tmux()<CR>", "Tmux")
nnoremap("<leader>sc", "<cmd>lua mm.cookbook()<CR>", "Cookbook")
