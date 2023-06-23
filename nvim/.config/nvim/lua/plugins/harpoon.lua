return {
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      -- Harpoon user interface
      vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Add to Harpoon" })
      vim.keymap.set("n", "<C-n>", ui.toggle_quick_menu, { desc = "Open Harpoon" })

      -- Harpoon marked files
      vim.keymap.set("n", "<A-1>", function() ui.nav_file(1) end)
      vim.keymap.set("n", "<A-2>", function() ui.nav_file(2) end)
      vim.keymap.set("n", "<A-3>", function() ui.nav_file(3) end)
      vim.keymap.set("n", "<A-4>", function() ui.nav_file(4) end)
    end
  }
}
