-------------------------------------------------------------------------------
--  Dashboard:
-------------------------------------------------------------------------------

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
    _3_new_file = {
      description = { " Novo Arquivo                          SPC f n" },
      command = "DashboardNewFile",
    },
    _4_new_note = {
      description = { " Nova Nota                             SPC z n" },
      command = "lua mm.new_note()",
    },
    _5_zettel = {
      description = { " Zettelkasten                          SPC z z" },
      command = "lua mm.zettelkasten()",
    },
    _6_find_word = {
      description = { " Buscar Palavras                       SPC s w" },
      command = "Telescope live_grep",
    },
    --[[
		_7_last_session = {
			description = { " Última sessão                         SPC s l" },
			command = "SessionLoad",
		},
		_8_find_nvim_conf = {
			description = { " Configurações                         SPC f d" },
			command = nvim_conf,
		},
		--]]
    _9_quit = {
      description = { " Sair                                  SPC q  " },
      command = "q",
    },
  }
  vim.g.dashboard_custom_footer = {}
end

return M
