local util = require('config.util')

local function large_preview(_, cols, _)
  if cols > 200 then
    return math.floor(cols * 0.4)
  else
    return math.floor(cols * 0.6)
  end
end

return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
      'nvim-lua/plenary.nvim',
      lazy = true,
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable('make') == 1
        end,
        config = function()
          require('telescope').load_extension('fzf')
        end,
      },
    },
    cmd = 'Telescope',
    keys = {
      -- git
      { '<leader>gc', '<cmd>Telescope git_commits<CR>', desc = '[G]it [C]ommits' },
      { '<leader>gs', '<cmd>Telescope git_status<CR>', desc = '[G]it [S]tatus' },

      -- search
      {
        '<C-p>',
        function()
          require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = '[F]iles (root)',
      },
      { '<C-b>', '<cmd>Telescope buffers<CR>', desc = '[B]uffers' },
      { '<leader>sf', util.telescope('files'), desc = '[S]earch [F]iles (root)' },
      { '<leader>sF', util.telescope('files', { cwd = false }), desc = '[S]earch [F]iles (cwd)' },
      { '<leader>sg', util.telescope('live_grep'), desc = '[S]earch by [G]rep' },
      { '<leader>sw', '<cmd>Telescope grep_string<CR>', desc = '[S]earch current [W]ord' },
      { '<leader>sh', '<cmd>Telescope help_tags<CR>', desc = '[S]earch [H]elp' },
      { '<leader>so', '<cmd>Telescope oldfiles<CR>', desc = '[S]earch [O]ld Files' },
      -- { '<leader>sc', '<cmd>Telescope commands<CR>', desc = '[S]earch [C]ommands' },
      -- { '<leader>sk', '<cmd>Telescope keymaps<CR>', desc = '[S]earch [K]eymaps' },
      -- { '<leader>sm', '<cmd>Telescope man_pages<CR>', desc = '[S]earch [M]anpages' },
      -- { '<leader>sO', '<cmd>Telescope vim_options<CR>', desc = '[S]earch [O]ptions' },
      {
        '<leader>/',
        function()
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = '[/] Fuzzily search in current buffer',
      },
      {
        '<leader>s/',
        function()
          require('telescope.builtin').live_grep({
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          })
        end,
        desc = '[S]earch [/] in Open Files',
      },
    },
    opts = {
      defaults = {
        prompt_prefix = ' ',
        selection_caret = ' ',
        winblend = 3,
        path_display = { 'smart', 'absolute', 'truncate' },
        file_ignore_patterns = {
          '%.o',
          '%.jpg',
          '%.jpeg',
          '%.png',
          '%.otf',
          '%.ttf',
          '%.gif',
          '.git/',
        },
        layout_strategy = 'horizontal',
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
            ['<C-j>'] = function(...)
              return require('telescope.actions').cycle_history_next(...)
            end,
            ['<C-k>'] = function(...)
              return require('telescope.actions').cycle_history_prev(...)
            end,
          },
        },
      },
      pickers = {
        buffers = {
          sort_mru = true,
          sort_lastused = true,
          show_all_buffers = true,
          theme = 'dropdown',
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
}
