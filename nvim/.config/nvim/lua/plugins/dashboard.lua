-------------------------------------------------------------------------------
--  Dashboard:
-------------------------------------------------------------------------------

mm.nnoremap("<leader>nf", "<cmd>DashboardNewFile<CR>")

local M = {}

M.config = function()
  vim.g.dashboard_disable_at_vimenter = 0
  vim.g.dashboard_default_executive = "telescope"

  vim.g.dashboard_custom_header = {
    "",
    "",
    "",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
    "",
    "       Trabalhar menos, trabalharmos todos. ☭ ",
    "    Produzir só o essencial e redistribuir tudo.",
  }

  vim.g.dashboard_custom_section = {
    _1_find_file = {
      description = { " Arquivos                              SPC s f" },
      command = "Telescope find_files",
    },
    _2_find_history = {
      description = { " Recentes                              SPC s r" },
      command = "Telescope oldfiles",
    },
    _3_find_word = {
      description = { " Buscar Palavras                       SPC s w" },
      command = "Telescope live_grep",
    },
    _4_new_file = {
      description = { " Novo Arquivo                          SPC n f" },
      command = "DashboardNewFile",
    },
    _5_new_note = {
      description = { " Nova Nota                             SPC z n" },
      command = "lua mm.new_note()",
    },
    _6_zettel = {
      description = { " Zettelkasten                          SPC z z" },
      command = "lua mm.zettelkasten()",
    },
    _7_quit = {
      description = { " Sair                                  SPC q  " },
      command = "q",
    },
  }
  -- vim.g.dashboard_custom_footer = {}
end

return M
