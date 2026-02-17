return {
  -- {
  --   "vague2k/vague.nvim",
  --   config = function()
  --     require("vague").setup({})
  --     vim.cmd.colorscheme "vague"
  --   end
  -- },
  {
    "cocopon/iceberg.vim",
    lazy = false,    -- load immediately so the colorscheme applies
    priority = 1000, -- ensure it loads before other plugins
    config = function()
      -- Enable true colors
      vim.opt.termguicolors = true

      -- Apply the Iceberg theme
      vim.cmd("colorscheme iceberg")
    end,
  }
}
