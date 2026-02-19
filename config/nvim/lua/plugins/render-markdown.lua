return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
  opts = {
    heading = {
      enabled = true,
      sign = false,
      icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
    },
    code = {
      enabled = true,
      sign = false,
      style = "full",
      left_pad = 1,
      right_pad = 1,
      border = "thin",
    },
  },
}
