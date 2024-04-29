return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        -- add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      preview_config = {
        border = 'rounded',
      },
      on_attach = function(buffer)
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end
        map('n', '<leader>gb', '<cmd>Gitsigns blame_line<CR>', '[G]it [B]lame')
        map('n', '<leader>gt', '<cmd>Gitsigns toggle_current_line_blame<CR>', '[G]it blame [T]oggle')
        map('n', '<leader>gr', '<cmd>Gitsigns reset_hunk<CR>', '[R]eset Hunk')
        map('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<CR>', '[P]review Hunk')
      end,
    },
  },
}
