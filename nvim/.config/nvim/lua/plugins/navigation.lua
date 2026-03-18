return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup({
        settings = {
          save_on_toggle = true,
        },
      })

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = 'Add to Harpoon' })

      vim.keymap.set('n', '<C-n>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Open Harpoon' })

      vim.keymap.set('n', '<leader>h', function()
        harpoon:list():select(1)
      end, { desc = 'Set harpoon 1' })
      vim.keymap.set('n', '<leader>j', function()
        harpoon:list():select(2)
      end, { desc = 'Set harpoon 2' })
      vim.keymap.set('n', '<leader>k', function()
        harpoon:list():select(3)
      end, { desc = 'Set harpoon 3' })
      vim.keymap.set('n', '<leader>l', function()
        harpoon:list():select(4)
      end, { desc = 'Set harpoon 4' })
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<leader>e', '<cmd>Neotree toggle<CR>', desc = '[E]xplorer' },
    },
    config = function()
      require('neo-tree').setup({
        window = {
          width = 35,
        },
        filesystem = {
          follow_current_file = { enabled = true },
        },
        default_component_configs = {
          icon = {
            folder_open = '',
            default = '',
          },
          git_status = {
            symbols = {
              added = '✚',
              deleted = '✖',
              modified = '',
              renamed = '󰁕',
              untracked = '',
              ignored = '',
              unstaged = '',
              staged = '',
              conflict = '',
            },
          },
        },
      })
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    version = false,
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-tree/nvim-web-devicons',              lazy = true },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-ui-select.nvim',
    },
    keys = {
      { '<C-b>',      '<cmd>Telescope buffers<CR>',                  desc = '[B]uffers' },
      { '<C-p>',      require('config.util').telescope('files', {}), desc = '[S]earch Files' },
      { '<leader>sf', '<cmd>Telescope find_files<CR>',               desc = '[S]earch [F]iles' },
      { '<leader>sg', '<cmd>Telescope git_files<CR>',                desc = '[S]earch [G]it Files' },
      { '<leader>sh', '<cmd>Telescope help_tags<CR>',                desc = '[S]earch [H]elp' },
      { '<leader>so', '<cmd>Telescope oldfiles<CR>',                 desc = '[S]earch [O]ld Files' },
      {
        '<leader>sw',
        function()
          require('telescope.builtin').grep_string({ search = vim.fn.input('Grep: ') })
        end,
        desc = '[S]earch [W]ord',
      },
      {
        '<leader>/',
        function()
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = '[/] Search in current buffer',
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
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'TelescopeResults',
        callback = function(ctx)
          vim.api.nvim_buf_call(ctx.buf, function()
            vim.fn.matchadd('TelescopeParent', '\t\t.*$')
            vim.api.nvim_set_hl(0, 'TelescopeParent', { link = 'Comment' })
          end)
        end,
      })

      local function formatted_name(_, path)
        local tail = vim.fs.basename(path)
        local parent = vim.fs.dirname(path)
        if parent == '.' then
          return tail
        end
        return string.format('%s\t\t%s', tail, parent)
      end

      telescope.setup({
        file_ignore_patterns = { '%.git/.' },
        defaults = {
          mappings = {
            i = {
              ['<esc>'] = actions.close,
            },
            n = {
              ['q'] = actions.close,
            },
          },
          previewer = false,
          prompt_prefix = ' ',
          selection_caret = ' ',
          file_ignore_patterns = { 'node_modules', 'package-lock.json' },
          initial_mode = 'insert',
          select_strategy = 'reset',
          sorting_strategy = 'ascending',
          color_devicons = true,
          set_env = { ['COLORTERM'] = 'truecolor' },
          layout_config = {
            prompt_position = 'top',
            preview_cutoff = 120,
          },
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
            '--glob=!.git/',
          },
        },
        pickers = {
          find_files = {
            previewer = false,
            path_display = formatted_name,
            layout_config = {
              height = 0.4,
              width = 0.6,
              prompt_position = 'top',
              preview_cutoff = 120,
            },
          },
          git_files = {
            previewer = false,
            path_display = formatted_name,
            layout_config = {
              height = 0.4,
              width = 0.6,
              prompt_position = 'top',
              preview_cutoff = 120,
            },
          },
          buffers = {
            path_display = formatted_name,
            mappings = {
              i = {
                ['<c-d>'] = actions.delete_buffer,
              },
              n = {
                ['<c-d>'] = actions.delete_buffer,
                ['<C-b>'] = actions.close,
              },
            },
            previewer = false,
            initial_mode = 'normal',
            layout_config = {
              height = 0.4,
              width = 0.6,
              prompt_position = 'top',
              preview_cutoff = 120,
            },
          },
          oldfiles = {
            path_display = formatted_name,
            layout_config = {
              height = 0.6,
              prompt_position = 'top',
              preview_cutoff = 120,
              preview_width = 0.6,
            },
          },
          current_buffer_fuzzy_find = {
            previewer = true,
            layout_config = {
              prompt_position = 'top',
              preview_cutoff = 120,
            },
          },
          live_grep = {
            only_sort_text = true,
            previewer = true,
          },
          grep_string = {
            only_sort_text = true,
            previewer = true,
          },
          lsp_references = {
            show_line = false,
            previewer = true,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
          ['ui-select'] = {
            require('telescope.themes').get_dropdown({
              previewer = false,
              initial_mode = 'normal',
              sorting_strategy = 'ascending',
              layout_strategy = 'horizontal',
              layout_config = {
                horizontal = {
                  width = 0.5,
                  height = 0.4,
                  preview_width = 0.6,
                },
              },
            }),
          },
        },
      })
      telescope.load_extension('fzf')
      telescope.load_extension('ui-select')
    end,
  },
}
