local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
  return
end

neorg.setup {
  -- Tell Neorg what modules to load
  load = {
    -- Load all the default modules
    ["core.defaults"] = {},
    -- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/default_keybinds.lua
    -- ["core.keybinds"] = {
    --   config = {
    --     default_keybinds = true,
    --     neorg_leader = "<leader>",
    --   },
    -- },
    -- Allows for use of icons
    ["core.norg.concealer"] = {},
    -- Manage your directories with Neorg
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          my_workspace = "~/neorg",
        },
      },
    },
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
        name = "[Neorg]"
      },
    },
  },
}

cmd("NeorgTaskDone", function()
  vim.cmd [[ Neorg keybind all core.norg.qol.todo_items.todo.task_done ]]
end)

cmd("NeorgTaskUndone", function()
  vim.cmd [[ Neorg keybind all core.norg.qol.todo_items.todo.task_undone ]]
end)

cmd("NeorgTaskPending", function()
  vim.cmd [[ Neorg keybind all core.norg.qol.todo_items.todo.task_undone ]]
end)

cmd("NeorgTaskOnHold", function()
  vim.cmd [[ Neorg keybind all core.norg.qol.todo_items.todo.task_on_hold ]]
end)

cmd("NeorgTaskCancelled", function()
  vim.cmd [[ Neorg keybind all core.norg.qol.todo_items.todo.task_cancelled ]]
end)

cmd("NeorgTaskRecurring", function()
  vim.cmd [[ Neorg keybind all core.norg.qol.todo_items.todo.task_recurring ]]
end)

cmd("NeorgTaskImportant", function()
  vim.cmd [[ Neorg keybind all core.norg.qol.todo_items.todo.task_important ]]
end)

cmd("NeorgTaskCycle", function()
  vim.cmd [[ Neorg keybind all core.norg.qol.todo_items.todo.task_cycle ]]
end)

map.group("silent", { ft = "norg" }, function()
  map.nname("<leader>n", "Neorg")
  nnoremap("<leader>nd", "<cmd>NeorgTaskDone<CR>", "Task done")
  nnoremap("<leader>nu", "<cmd>NeorgTaskUndone<CR>", "Task undone")
  nnoremap("<leader>np", "<cmd>NeorgTaskPending<CR>", "Task pending")
  nnoremap("<leader>nh", "<cmd>NeorgTaskOnHold<CR>", "Task on hold")
  nnoremap("<leader>nc", "<cmd>NeorgTaskCancelled<CR>", "Task cancelled")
  nnoremap("<leader>nr", "<cmd>NeorgTaskRecurring<CR>", "Task recurring")
  nnoremap("<leader>ni", "<cmd>NeorgTaskImportant<CR>", "Task important")
  nnoremap("<C-space>", "<cmd>NeorgTaskCycle<CR>")
end)

local ok, treesitter_parsers = pcall(require, "nvim-treesitter.parsers")
if ok then
  local parser_configs = treesitter_parsers.get_parser_configs()

  parser_configs.norg = {
    install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg",
      files = { "src/parser.c", "src/scanner.cc" },
      branch = "main",
    },
  }

  parser_configs.norg_meta = {
    install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
      files = { "src/parser.c" },
      branch = "main",
    },
  }

  parser_configs.norg_table = {
    install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
      files = { "src/parser.c" },
      branch = "main",
    },
  }
end
