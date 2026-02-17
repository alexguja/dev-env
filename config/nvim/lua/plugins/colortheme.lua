return {
  -- {
  --   "vague2k/vague.nvim",
  --   config = function()
  --     require("vague").setup({})
  --     vim.cmd.colorscheme "vague"
  --   end
  -- },
  -- {
  --   "cocopon/iceberg.vim",
  --   lazy = false,    -- load immediately so the colorscheme applies
  --   priority = 1000, -- ensure it loads before other plugins
  --   config = function()
  --     -- Enable true colors
  --     vim.opt.termguicolors = true
  --
  --     -- Apply the Iceberg theme
  --     vim.cmd("colorscheme iceberg")
  --   end,
  -- }
  {
    "kvrohit/substrata.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      -- Optional: configure before loading
      -- vim.g.substrata_italic_comments = true
      -- vim.g.substrata_italic_keywords = false
      -- vim.g.substrata_transparent = false
      vim.cmd("colorscheme substrata")

      -- Fix: Clear Neovim 0.10+ default treesitter highlights that override theme
      -- These default to NvimLightGrey which appears white
      local groups_to_clear = {
        "@variable",
        "@variable.builtin",
        "@variable.parameter",
        "@variable.member",
        "@constant",
        "@constant.builtin",
        "@module",
        "@label",
      }
      for _, group in ipairs(groups_to_clear) do
        vim.api.nvim_set_hl(0, group, {})
      end
    end,
  }
}
