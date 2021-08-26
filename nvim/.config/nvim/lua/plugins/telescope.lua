-------------------------------------------------------------------------------
--  Telescope:
-------------------------------------------------------------------------------

require("telescope").setup {
  defaults = {
    prompt_prefix = "❯ ",
    layout_config = { prompt_position = "top" },
    selection_caret = " ",
    sorting_strategy = "ascending",
  },
  path_display = { shorten = 5 },
}

-- Nvim config
function mm.edit_nvim()
  require("telescope.builtin").find_files {
    cwd = "~/.dotfiles/nvim/.config/nvim/",
    prompt_title = "Neovim Configuration",
    hidden = true,
  }
end

-- Zsh config
function mm.edit_zsh()
  require("telescope.builtin").find_files {
    shorten_path = false,
    cwd = "~/.dotfiles/zsh/.config/zsh/",
    prompt_title = "Zsh Configuration",
    hidden = false,
  }
end

-- Tmux config
function mm.edit_tmux()
  require("telescope.builtin").find_files {
    shorten_path = false,
    cwd = "~/.dotfiles/tmux/.config/tmux/",
    prompt_title = "Tmux Configuration",
    hidden = true,
  }
end

-- Zettelkasten
local zettel = {
  home = "~/Documentos/Conhecimento/Notas/",
  prompt = "Zettelkasten",
  results = "Notes",
}

function mm.zettelkasten()
  require("telescope.builtin").find_files {
    shorten_path = false,
    cwd = zettel.home,
    prompt_title = zettel.prompt,
    results_title = zettel.results,
    hidden = true,
  }
end

function mm.new_note()
  local timestamp = os.date "%Y %m %d %H %M"
  local note = timestamp:gsub("%s+", "") .. ".md"
  vim.cmd("e " .. zettel.home .. note)
end

function mm.cookbook()
  require("telescope.builtin").live_grep {
    shorten_path = false,
    cwd = "~/Dropbox/CookBook/",
    prompt_title = "CookBook",
    results_title = "Notes",
    hidden = false,
  }
end

-- Usa a interface do Telescope para exibir as code_actions
local themes = require "telescope.themes"
function Lsp_code_actions()
  local opts = themes.get_dropdown {
    winblend = 0,
    border = true,
    previewer = false,
    shorten_path = false,
  }

  require("telescope.builtin").lsp_code_actions(opts)
end
