return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy = "vertical",
          mappings = {
            n = {
              ["d"] = require("telescope.actions").delete_buffer,
              ["<esc>"] = require("telescope.actions").close,
            },
            i = {
              ['<C-t>'] = require('telescope.actions.layout').toggle_preview
            },
            -- preview = {
            --   hide_on_startup = true
            -- },
          },
        },
        extensions = {
          ['ui-select'] = {
            require("telescope.themes").get_dropdown {
            }
          }
        }
      })

      local builtin = require("telescope.builtin")
      vim.keymap.set('n', '<C-p>', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>sr', builtin.resume, {})
      vim.keymap.set('n', '<leader>gr', builtin.lsp_references, { desc = 'Telescope LSP references' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      require("telescope").load_extension("ui-select")
    end
  },
}
